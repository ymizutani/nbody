

.PHONY: build wait run doc clean


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
	rm -fr output
