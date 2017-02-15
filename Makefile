

.PHONY: build wait run doc clean


build:
	processing-java --sketch=../nbody --output=output --force --build 

wait:
	@while :; do \
        inotifywait *.pde 1>/dev/null 2>&1;\
        echo "==== `date` ====";\
        processing-java --sketch=../nbody --output=output --force --build;\
    done

run:
	processing-java --sketch=../nbody --output=output --force --run

doc:
	doxygen

clean:
	rm -fr output
