

.PHONY: build wait run doc clean


build:
	processing-java --build --sketch=../nbody --output=output --force

wait:
	@while :; do \
        inotifywait *.pde 1>/dev/null 2>&1;\
        echo "==== `date` ====";\
        processing-java --build --sketch=../nbody --output=output --force;\
    done

run:
	processing-java --run --sketch=../nbody --output=output --force

doc:
	doxygen

clean:
	rm -fr output

