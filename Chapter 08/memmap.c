

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

#define GPIO1_START_ADDR 0x13040000	// 0x4804C000
#define GPIO1_END_ADDR   0x13042000	// 0x4804e000
#define GPIO1_SIZE (GPIO1_END_ADDR - GPIO1_START_ADDR)

#define GPIO_SETDATAOUT 0x0
#define GPIO_CLEARDATAOUT 0x40
#define GPIO_ENABLE 0x0
#define GPIO_SET 0x40

#define USR3 (1<<24)

volatile void *gpio_addr;

volatile unsigned int *doen_reg;
volatile unsigned int *dout_reg;

int dout_mask = 0x7f;
int doen_mask = 0x3f;

void set(unsigned int pin)
{
	unsigned int offset = pin / 4;
	unsigned int shift = 8 * (pin % 4);
	
	unsigned int dout = dout_reg[offset];
	unsigned int doen = doen_reg[offset];

printf("dout_reg addr = %x doen_reg addr = %x\n", &dout_reg[offset], &doen_reg[offset]);	
printf("dout and val = %x  doen and val = %x\n", ~(dout_mask << shift) | (1 << shift), ~(doen_mask << shift));	
printf("dout val = %x doen val = %x\n", dout & ~(dout_mask << shift) | (1 << shift), doen & ~(doen_mask << shift));
printf("dout_reg = %x doen_reg = %x\n", dout_reg, doen_reg);
	dout_reg[offset] = dout & ~(dout_mask << shift) | (1 << shift);
	doen_reg[offset] = doen & ~(doen_mask << shift);
}

void clear(unsigned int pin)
{
	unsigned int offset = pin / 4;
	unsigned int shift = 8 * (pin % 4);

	unsigned int dout = dout_reg[offset];
	dout_reg[offset] = dout & ~(dout_mask << shift);

}

int main()
{
volatile unsigned int *gpio_setdataout_addr;
volatile unsigned int *gpio_cleardataout_addr;
int fd = open("/dev/mem", O_RDWR);
gpio_addr = mmap(0, GPIO1_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, GPIO1_START_ADDR);

dout_reg = gpio_addr + GPIO_SET;
doen_reg = gpio_addr + GPIO_ENABLE;

gpio_setdataout_addr   = gpio_addr + GPIO_SETDATAOUT;
gpio_cleardataout_addr = gpio_addr + GPIO_CLEARDATAOUT;
printf("reg1 = %x reg2 = %x\n", *gpio_setdataout_addr, *gpio_cleardataout_addr);

set(50);
set(54);
set(51);
sleep(10);
clear(50);
clear(54);
clear(51);
}
