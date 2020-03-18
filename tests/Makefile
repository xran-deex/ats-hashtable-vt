
test: main

main: main.dats
	patscc -IATS .. -IATS ../node_modules -DATS_MEMALLOC_LIBC -o main main.dats -cleanaft 

clean:
	$(RM) main

.SILENT: clean