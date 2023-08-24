package parallel;

import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;

import processing.core.PApplet;
import processing.core.PGraphics;

abstract public class ParallelTask implements Runnable, Cloneable{
	private static int pnum;  //並列数
	private int myrank;		  //自身のランク
	private static CyclicBarrier barrier; //同期処理を行うための変数

	public PGraphics pg;	//描画領域
	
	//スレッド間のデータのやりとりを行うための変数
	int sendtype = -1;  //何も送信しないとき=-1, int[]型データを送信=1, double[]型=2
	int[] sendInteger;
	double[] sendDouble;
    int bcastrank = -1; //Bcastをする際の送信元(送信しないときは-1)
	private CyclicBarrier[] recvbarrier; //1対1のデータ送受信用
	private static CyclicBarrier bcastbarrier; //1対多のデータ送受信用

	
	//継承したクラスではこのメソッドをオーバーライドして使用
	abstract public void run();
	
	//現在の並列数を取得
	final public int getPnum() {
		return ParallelTask.pnum;
	}
	
	//自身のランクを取得
	final public int getMyrank() {
		return this.myrank;
	}
	
	//全てのスレッドがこのメソッドを行うまで待機(同期処理)
	final public void Barrier() {
		try{
			barrier.await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
	}
	
	//rankのスレッドにint型の配列データを先頭からsizeの分だけ送る
	//rankのスレッドがRecvメソッドを行うまで待機して送信を行う
	final public void Send(int rank, int[] data, int size) {
		this.sendtype = 1;
		this.sendInteger = new int[size];
		System.arraycopy(data, 0, this.sendInteger, 0, size);
				
		try{
			Parallel.tasks[rank].recvbarrier[this.myrank].await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		try{
			Parallel.tasks[rank].recvbarrier[this.myrank].await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		this.sendtype = -1;
		
		
	}
	
	//double型の配列を送信
	final public void Send(int rank, double[] data, int size) {
		this.sendtype = 2;
		this.sendDouble = new double[size];
		System.arraycopy(data, 0, this.sendDouble, 0, size);
				
		try{
			Parallel.tasks[rank].recvbarrier[this.myrank].await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		try{
			Parallel.tasks[rank].recvbarrier[this.myrank].await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		this.sendtype = -1;
		
		
	}
	
	//rankから送られてきたint型の配列をdataにsize分だけ格納
	//rankのスレッドがSendメソッドを行うまで待機して受信を行う
	final public void Recv(int rank, int[] data, int size) {
		try{
			this.recvbarrier[rank].await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		if(Parallel.tasks[rank].sendtype != 1) {
			System.err.println("Recv:配列の型が不適切です");
			System.exit(1);
		}
		if(Parallel.tasks[rank].sendInteger.length < size) {
			System.err.println("Recv:配列の要素数が不適切です");
			System.exit(1);
		}

		System.arraycopy(Parallel.tasks[rank].sendInteger, 0, data, 0, size);

		try{
			this.recvbarrier[rank].await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
	}
	
	//double型の配列を受信
	final public void Recv(int rank, double[] data, int size) {
		try{
			this.recvbarrier[rank].await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		if(Parallel.tasks[rank].sendtype != 2) {
			System.err.println("Recv:配列の型が不適切です");
			System.exit(1);
		}
		if(Parallel.tasks[rank].sendDouble.length < size) {
			System.err.println("Recv:配列の要素数が不適切です");
			System.exit(1);
		}

		System.arraycopy(Parallel.tasks[rank].sendDouble, 0, data, 0, size);

		try{
			this.recvbarrier[rank].await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
	}
	
	//rankのスレッドはint型の配列dataを自身以外のスレッドに送信
	//rank以外のスレッドはrankから送られてきた配列をdataに格納
	//全てのスレッドがBcastメソッドを行うまで待機してから送受信
	final public void Bcast(int rank, int[] data, int size) {
		if(this.myrank == rank) {
			this.sendtype = 1;
			this.sendInteger = new int[size];
			System.arraycopy(data, 0, this.sendInteger, 0, size);
		}
		this.bcastrank = rank;
		
		try{
			ParallelTask.bcastbarrier.await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		if(this.myrank == rank) {
			for(int i=0; i<ParallelTask.pnum; i++) {
				if(Parallel.tasks[i].bcastrank != rank) {
					System.err.println("Bcast:rankが不適切です");
					System.exit(1);
				}
			}
		}
		
		try{
			ParallelTask.bcastbarrier.await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		if(this.myrank != rank) {
			if(Parallel.tasks[rank].sendtype != 1) {
				System.err.println("Bcast:配列の型が不適切です");
				System.exit(1);
			}
			if(Parallel.tasks[rank].sendInteger.length < size) {
				System.err.println("Bcast:配列の要素数が不適切です");
				System.exit(1);
			}
			
			System.arraycopy(Parallel.tasks[rank].sendInteger, 0, data, 0, size);
		}
		
		try{
			ParallelTask.bcastbarrier.await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		if(this.myrank == rank) {
			this.sendtype = -1;
		}	
	}
	
	//double型のdataを全てのスレッドに送信
	final public void Bcast(int rank, double[] data, int size) {
		if(this.myrank == rank) {
			this.sendtype = 2;
			this.sendDouble = new double[size];
			System.arraycopy(data, 0, this.sendDouble, 0, size);
		}
		this.bcastrank = rank;
		
		try{
			ParallelTask.bcastbarrier.await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		if(this.myrank == rank) {
			for(int i=0; i<ParallelTask.pnum; i++) {
				if(Parallel.tasks[i].bcastrank != rank) {
					System.err.println("Bcast:rankが不適切です");
					System.exit(1);
				}
			}
		}
		
		try{
			ParallelTask.bcastbarrier.await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		if(this.myrank != rank) {
			if(Parallel.tasks[rank].sendtype != 2) {
				System.err.println("Bcast:配列の型が不適切です");
				System.exit(1);
			}
			if(Parallel.tasks[rank].sendDouble.length < size) {
				System.err.println("Bcast:配列の要素数が不適切です");
				System.exit(1);
			}
			
			System.arraycopy(Parallel.tasks[rank].sendDouble, 0, data, 0, size);
		}
		
		try{
			ParallelTask.bcastbarrier.await();
		}catch(InterruptedException e){
			e.printStackTrace();
		}catch(BrokenBarrierException e) {
			e.printStackTrace();
		}
		
		if(this.myrank == rank) {
			this.sendtype = -1;
		}	
	}
	
	//以下のメソッドは継承したクラス内では使用できない
	
	//pnumの初期化
	final static void setPnum(int pnum) {
		ParallelTask.pnum = pnum;
		ParallelTask.barrier = new CyclicBarrier(pnum);
		ParallelTask.bcastbarrier = new CyclicBarrier(pnum);
		
	}
	
	//myrankの初期化
	final void setMyrank(int rank) {
		this.myrank = rank;
	}
	
	//PGraphics型のpgの初期化
	final void setPGraphics(PApplet p) {
		pg = p.createGraphics(p.width, p.height);
	}
	
	//SendやRecvを実行する際に足並みをそろえるためのCyclicbarrierを初期化
	final void setBarrier() {
		recvbarrier = new CyclicBarrier[ParallelTask.pnum];
		for(int i=0; i<ParallelTask.pnum; i++) {
			recvbarrier[i] = new CyclicBarrier(2);
		}
	}
	
	//インスタンスの複製
	final protected ParallelTask clone() throws CloneNotSupportedException {
		return (ParallelTask)super.clone();
	}
	

}