
test: main

main:
	patscc -IATS .. -IATS ../node_modules -DATS_MEMALLOC_LIBC -o main main.dats -L ../build -lhashtbl-vt -cleanaft

clean:
	$(RM) main

.SILENT: clean