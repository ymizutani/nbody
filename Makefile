

.PHONY: build wait run doc clean

tmpdir  =   ./tmp
pdir    =   /c/Users/mizutani/MyData/Programming/processing-4.3


build:
	processing-java --sketch=`pwd` --output=`pwd`/output --force --build 

wait:
	@while :; do \
        inotifywait *.pde 1>/dev/null 2>&1;\
        echo "==== `date` ====";\
        processing-java --sketch=`pwd` --output=`pwd`/output --force --build;\
    done

run:
	processing-java --sketch=`pwd` --output=`pwd`/output --force --run

doc:
	doxygen

clean:
	rm -fr output *.class paralle.jar $(tmpdir)

jar:
	rm -fr $(tmpdir)
	mkdir -p $(tmpdir)
	cp $(pdir)/core/library/core.jar $(tmpdir)/
	cp Parallel.java ParallelTask.java $(tmpdir)/
	(\
        cd $(tmpdir) ;\
        $(pdir)/java/bin/javac -encoding utf8 -cp 'core.jar;.' Parallel.java ParallelTask.java ;\
        mkdir parallel ;\
        mv Parallel.class ParallelTask.class parallel/ ;\
        $(pdir)/java/bin/jar -cf parallel.jar parallel ;\
    )

