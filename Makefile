GPPPARAM = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAM  = --32
LDPARAMS = -melf_i386

objects = loader.o kernel.o

%.o: %.cpp
	g++ $(GPPPARAM) -o $@ -c $<
	
%.o: %.s
	as $(ASPARAM) -o $@ -c $<
	
mykernel.bin : linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)
	
install: mykernel.bin
	sudo cp $< /boot/mykernel.bin