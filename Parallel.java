package parallel;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;

public class Parallel extends PApplet{
    public static PApplet p;
	public static int pnum;	
	static ExecutorService exe;
	static List<Future<?>> futures = new ArrayList<Future<?>>();
	public static ParallelTask[] tasks;
	
	//時間を自動で計測するための変数
	public static double paratime_sum[] = new double[8];
	public static int count_para[] = new int[8];
	public static double mergetime_sum[] = new double[8];
	public static int count_merge[] = new int[8]; 
	
	//初期化メソッド(task=ParallelTaskを継承したインスタンス, pnum=並列数, pの部分はthisと記述)
	public static void init(ParallelTask task, int pnum, PApplet p) {
		Parallel.p = p;
		Parallel.exe = Executors.newCachedThreadPool();
		Parallel.pnum = pnum;
		 
		Parallel.tasks = new ParallelTask[pnum];
		Parallel.tasks[0] = task;
		 
		 
		for(int i=1; i<pnum; i++) {
			try {
			    Parallel.tasks[i] = (ParallelTask)tasks[0].clone();
			} catch (CloneNotSupportedException e) {
				e.printStackTrace();
			}
		}
		ParallelTask.setPnum(pnum);
		for(int i=0; i<pnum; i++) {
			Parallel.tasks[i].setMyrank(i);
			Parallel.tasks[i].setPGraphics(p);
			Parallel.tasks[i].setBarrier();
		}
	}
	
	//並列処理の起動
	public static void exec() {
		for(int i=0; i<Parallel.pnum; i++) {
			Parallel.exe.submit(tasks[i]);
		}
	}
	
	//並列処理がすべて終了するまで待機するver
	public static double fexec() {  
		double start = System.nanoTime();
		for(int i=0; i<Parallel.pnum; i++) {
			futures.add(Parallel.exe.submit(tasks[i]));
		}
		for(Future<?> future : futures){
		    try{
		        future.get();
		    }catch(Exception e){
		        e.printStackTrace();
		    }
		}
		futures.clear();
		double end = System.nanoTime();
		
		paratime_sum[pnum-1] += (end - start) /1000000000;
		count_para[pnum-1]++;
		
		return (end - start)/1000000000;
	}
	
	//シャットダウン　このメソッド実行以降新しく並列処理を起動できない 
	public static void shut() {
		Parallel.exe.shutdown();
	}
	

	//描画領域の統合　デフォルトは3(image重ね合わせ方式)
	public static double merge() {
        merger(3);
    }

	//描画領域の統合　num=1...blend方式 2...クロマキー方式 3...image重ね合わせ方式
	public static double merge(int num) {
		double start = System.nanoTime();
		if(num == 1) {
			for(int i=1; i<pnum; i++) {
				tasks[0].pg.blend(tasks[i].pg, 0, 0, p.width, p.height, 0, 0, p.width, p.height, DARKEST);
			}
			p.image(tasks[0].pg, 0, 0);   
		}else if(num == 2) {
			PImage img = tasks[0].pg.get();
			float r1, r2, g1, g2, b1, b2;
			
			for(int y=0; y<p.height; y++) {
				for(int x=0; x<p.width; x++) {
					r1 =  p.red(tasks[0].pg.get(x, y));
					g1 =  p.green(tasks[0].pg.get(x, y));
					b1 =  p.blue(tasks[0].pg.get(x, y)); 
					
					if (r1 == 255 && g1 == 255 && b1 == 255){
						for(int i=1; i<pnum; i++) {
							r2 =  p.red(tasks[i].pg.get(x, y));
							g2 =  p.green(tasks[i].pg.get(x, y));
							b2 =  p.blue(tasks[i].pg.get(x, y));
							if(r1+g1+b1 > r2+g2+b2) {
								img.set(x, y, p.color(r2,g2,b2));
				                break;
							}
						}
					}
				}
			}
			p.image(img, 0, 0);
		}else if (num == 3) {
			for(int i=0; i<pnum; i++) {
				p.image(tasks[i].pg, 0, 0);
			}
		}
		double end = System.nanoTime();
		
		mergetime_sum[pnum-1] += (end - start) / 1000000000;
		count_merge[pnum-1]++;
		
		return (end - start)/1000000000;
	}
	

	//自動計測した時間を元にグラフを作成
	//作成したグラフは画像ファイルとして自動で保存される
	public static void createGraph() {
		PGraphics graph = p.createGraphics(1000, 750); //グラフを描画する領域
		
		double para[] = new double[8];
		double merge[] = new double[8];
		int graph_pnum[] = new int[8];
		
		
		int count = 0;  //グラフの数
		for(int i = 0; i<8; i++) {
			if(count_para[i] > 0 || count_merge[i] > 0) {
				if(count_para[i] != 0) {
				    para[count] = paratime_sum[i] / count_para[i];
				}else {
					para[count] = 0;
				}
				if(count_merge[i] != 0) {
					merge[count] = mergetime_sum[i] / count_merge[i];
				}else {
					merge[count] = 0;
				}
				graph_pnum[count] = i;
				count++;
			}
		}

		graph.beginDraw();
		graph.background(255);
	    graph.noFill();
		graph.strokeWeight(5);
		graph.stroke(150);
		graph.rect((float)(graph.width*0.15), (float)(graph.height*0.1), (float)(graph.width*0.8), (float)(graph.height*0.7));
		graph.strokeWeight(1);
		graph.textFont(p.createFont("メイリオ", 15));	
		graph.textAlign(CENTER);
		
		
		double max = merge[0] + para[0];
		for(int i=1; i<count; i++){
		   if(max < merge[i]+para[i]){
			   max = merge[i]+para[i];
		   }
		}
		double graph_max = 1.0;
		if(max>=1){   
		    while(true){
		    	if(graph_max >= max) break;
		    	graph_max *= 10;
		    }   
		}else{
		    while(true){
		      if(graph_max < max){
		    	  graph_max *= 10;
		    	  break;
		      }
		      graph_max /= 10;
		    }
		}
		  
		double tmp = graph_max; 
		while(true){
		    if(graph_max < max) {
		        graph_max += tmp/4;
		        break;
		    }
		    graph_max -= tmp/4;
		    
		}
		
		
		for(int i=1; i<5; i++){
			graph.line((float)(graph.width*0.15+graph.width*0.8/5*i), (float)(graph.height*0.1), (float)(graph.width*0.15+graph.width*0.8/5*i), (float)(graph.height*0.1+graph.height*0.7));
		}
	    graph.fill(0);
		for(int i=0; i<=5; i++){
			graph.text((float)(graph_max*i/5) ,(float)(graph.width*0.15+graph.width*0.8/5*i), (float)(graph.height*0.85));
		}
		graph.textFont(p.createFont("メイリオ", 20));
		graph.text("時間[秒]", (float)(graph.width*0.55), (float)(graph.height*0.9));
		
		graph.noStroke();
		graph.fill(0,0,255);
		graph.rect((float)(graph.width*0.3), (float)(graph.height*0.92), 20, 20);
		
		graph.textFont(p.createFont("メイリオ", 20));
		graph.textAlign(LEFT);
		  
		graph.fill(255,255,0);
		graph.rect((float)(graph.width*0.6), (float)(graph.height*0.92), 20, 20);
		  
		graph.fill(0);
		graph.text(":画像統合時間", (float)(graph.width*0.3+22), (float)(graph.height*0.942));
		graph.text(":並列処理時間", (float)(graph.width*0.6+22), (float)(graph.height*0.942));
		
		graph.textAlign(LEFT, CENTER);
		for(int i=0; i<count; i++){
		    graph.text((graph_pnum[i]+1) + "スレッド",(float)(graph.width*0.05), (float)(graph.height*0.8-graph.height*0.7/(count+1)*(i+1)));
		}
		  
		double rect_h;
		rect_h = graph.height*0.5 /count;
		if(rect_h > graph.height*0.7/5) rect_h = graph.height*0.7/5;
		System.out.println("==================================");
		System.out.println("スレッド数\t描画領域統合時間[s]\t並列処理時間[s]");
		for(int i=0; i<count; i++){
		    float a = (float)merge[i];
		    graph.fill(0,0,255);
		    graph.rect((float)(graph.width*0.15), (float)(graph.height*0.8-graph.height*0.7/(count+1)*(i+1)-rect_h/2), (float)(graph.width*0.8*a/graph_max), (float)(rect_h));	    
		    float b = (float)para[i];
		    graph.fill(255,255,0);
		    graph.rect((float)(graph.width*0.15+graph.width*0.8*a/graph_max), (float)(graph.height*0.8-graph.height*0.7/(count+1)*(i+1)-rect_h/2), (float)(graph.width*0.8*b/graph_max), (float)(rect_h));
		    System.out.println((graph_pnum[i]+1) + "スレッド:\t" + a + "\t" + b);
		}
		graph.endDraw();
		
		graph.save("time.png");
		
		
	}
	
	
}
