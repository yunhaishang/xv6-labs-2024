
user/_sleep：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  int ticks;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	00a7dc63          	bge	a5,a0,22 <main+0x22>
    fprintf(2, "Usage: sleep <ticks>\n");
    exit(1);
  }

  ticks = atoi(argv[1]);
   e:	6588                	ld	a0,8(a1)
  10:	1ae000ef          	jal	1be <atoi>

  if(ticks <= 0){
  14:	02a05163          	blez	a0,36 <main+0x36>
    fprintf(2, "sleep: ticks should bigger than 0\n");
    exit(1);
  }

  sleep(ticks);
  18:	32c000ef          	jal	344 <sleep>

  exit(0);
  1c:	4501                	li	a0,0
  1e:	296000ef          	jal	2b4 <exit>
    fprintf(2, "Usage: sleep <ticks>\n");
  22:	00001597          	auipc	a1,0x1
  26:	85e58593          	addi	a1,a1,-1954 # 880 <malloc+0x100>
  2a:	4509                	li	a0,2
  2c:	676000ef          	jal	6a2 <fprintf>
    exit(1);
  30:	4505                	li	a0,1
  32:	282000ef          	jal	2b4 <exit>
    fprintf(2, "sleep: ticks should bigger than 0\n");
  36:	00001597          	auipc	a1,0x1
  3a:	86258593          	addi	a1,a1,-1950 # 898 <malloc+0x118>
  3e:	4509                	li	a0,2
  40:	662000ef          	jal	6a2 <fprintf>
    exit(1);
  44:	4505                	li	a0,1
  46:	26e000ef          	jal	2b4 <exit>

000000000000004a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e406                	sd	ra,8(sp)
  4e:	e022                	sd	s0,0(sp)
  50:	0800                	addi	s0,sp,16
  extern int main();
  main();
  52:	fafff0ef          	jal	0 <main>
  exit(0);
  56:	4501                	li	a0,0
  58:	25c000ef          	jal	2b4 <exit>

000000000000005c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  5c:	1141                	addi	sp,sp,-16
  5e:	e422                	sd	s0,8(sp)
  60:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  62:	87aa                	mv	a5,a0
  64:	0585                	addi	a1,a1,1
  66:	0785                	addi	a5,a5,1
  68:	fff5c703          	lbu	a4,-1(a1)
  6c:	fee78fa3          	sb	a4,-1(a5)
  70:	fb75                	bnez	a4,64 <strcpy+0x8>
    ;
  return os;
}
  72:	6422                	ld	s0,8(sp)
  74:	0141                	addi	sp,sp,16
  76:	8082                	ret

0000000000000078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  7e:	00054783          	lbu	a5,0(a0)
  82:	cb91                	beqz	a5,96 <strcmp+0x1e>
  84:	0005c703          	lbu	a4,0(a1)
  88:	00f71763          	bne	a4,a5,96 <strcmp+0x1e>
    p++, q++;
  8c:	0505                	addi	a0,a0,1
  8e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  90:	00054783          	lbu	a5,0(a0)
  94:	fbe5                	bnez	a5,84 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  96:	0005c503          	lbu	a0,0(a1)
}
  9a:	40a7853b          	subw	a0,a5,a0
  9e:	6422                	ld	s0,8(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret

00000000000000a4 <strlen>:

uint
strlen(const char *s)
{
  a4:	1141                	addi	sp,sp,-16
  a6:	e422                	sd	s0,8(sp)
  a8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  aa:	00054783          	lbu	a5,0(a0)
  ae:	cf91                	beqz	a5,ca <strlen+0x26>
  b0:	0505                	addi	a0,a0,1
  b2:	87aa                	mv	a5,a0
  b4:	86be                	mv	a3,a5
  b6:	0785                	addi	a5,a5,1
  b8:	fff7c703          	lbu	a4,-1(a5)
  bc:	ff65                	bnez	a4,b4 <strlen+0x10>
  be:	40a6853b          	subw	a0,a3,a0
  c2:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  c4:	6422                	ld	s0,8(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret
  for(n = 0; s[n]; n++)
  ca:	4501                	li	a0,0
  cc:	bfe5                	j	c4 <strlen+0x20>

00000000000000ce <memset>:

void*
memset(void *dst, int c, uint n)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e422                	sd	s0,8(sp)
  d2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d4:	ca19                	beqz	a2,ea <memset+0x1c>
  d6:	87aa                	mv	a5,a0
  d8:	1602                	slli	a2,a2,0x20
  da:	9201                	srli	a2,a2,0x20
  dc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e4:	0785                	addi	a5,a5,1
  e6:	fee79de3          	bne	a5,a4,e0 <memset+0x12>
  }
  return dst;
}
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret

00000000000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	1141                	addi	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	addi	s0,sp,16
  for(; *s; s++)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cb99                	beqz	a5,110 <strchr+0x20>
    if(*s == c)
  fc:	00f58763          	beq	a1,a5,10a <strchr+0x1a>
  for(; *s; s++)
 100:	0505                	addi	a0,a0,1
 102:	00054783          	lbu	a5,0(a0)
 106:	fbfd                	bnez	a5,fc <strchr+0xc>
      return (char*)s;
  return 0;
 108:	4501                	li	a0,0
}
 10a:	6422                	ld	s0,8(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret
  return 0;
 110:	4501                	li	a0,0
 112:	bfe5                	j	10a <strchr+0x1a>

0000000000000114 <gets>:

char*
gets(char *buf, int max)
{
 114:	711d                	addi	sp,sp,-96
 116:	ec86                	sd	ra,88(sp)
 118:	e8a2                	sd	s0,80(sp)
 11a:	e4a6                	sd	s1,72(sp)
 11c:	e0ca                	sd	s2,64(sp)
 11e:	fc4e                	sd	s3,56(sp)
 120:	f852                	sd	s4,48(sp)
 122:	f456                	sd	s5,40(sp)
 124:	f05a                	sd	s6,32(sp)
 126:	ec5e                	sd	s7,24(sp)
 128:	1080                	addi	s0,sp,96
 12a:	8baa                	mv	s7,a0
 12c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12e:	892a                	mv	s2,a0
 130:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 132:	4aa9                	li	s5,10
 134:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 136:	89a6                	mv	s3,s1
 138:	2485                	addiw	s1,s1,1
 13a:	0344d663          	bge	s1,s4,166 <gets+0x52>
    cc = read(0, &c, 1);
 13e:	4605                	li	a2,1
 140:	faf40593          	addi	a1,s0,-81
 144:	4501                	li	a0,0
 146:	186000ef          	jal	2cc <read>
    if(cc < 1)
 14a:	00a05e63          	blez	a0,166 <gets+0x52>
    buf[i++] = c;
 14e:	faf44783          	lbu	a5,-81(s0)
 152:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 156:	01578763          	beq	a5,s5,164 <gets+0x50>
 15a:	0905                	addi	s2,s2,1
 15c:	fd679de3          	bne	a5,s6,136 <gets+0x22>
    buf[i++] = c;
 160:	89a6                	mv	s3,s1
 162:	a011                	j	166 <gets+0x52>
 164:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 166:	99de                	add	s3,s3,s7
 168:	00098023          	sb	zero,0(s3)
  return buf;
}
 16c:	855e                	mv	a0,s7
 16e:	60e6                	ld	ra,88(sp)
 170:	6446                	ld	s0,80(sp)
 172:	64a6                	ld	s1,72(sp)
 174:	6906                	ld	s2,64(sp)
 176:	79e2                	ld	s3,56(sp)
 178:	7a42                	ld	s4,48(sp)
 17a:	7aa2                	ld	s5,40(sp)
 17c:	7b02                	ld	s6,32(sp)
 17e:	6be2                	ld	s7,24(sp)
 180:	6125                	addi	sp,sp,96
 182:	8082                	ret

0000000000000184 <stat>:

int
stat(const char *n, struct stat *st)
{
 184:	1101                	addi	sp,sp,-32
 186:	ec06                	sd	ra,24(sp)
 188:	e822                	sd	s0,16(sp)
 18a:	e04a                	sd	s2,0(sp)
 18c:	1000                	addi	s0,sp,32
 18e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 190:	4581                	li	a1,0
 192:	162000ef          	jal	2f4 <open>
  if(fd < 0)
 196:	02054263          	bltz	a0,1ba <stat+0x36>
 19a:	e426                	sd	s1,8(sp)
 19c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 19e:	85ca                	mv	a1,s2
 1a0:	16c000ef          	jal	30c <fstat>
 1a4:	892a                	mv	s2,a0
  close(fd);
 1a6:	8526                	mv	a0,s1
 1a8:	134000ef          	jal	2dc <close>
  return r;
 1ac:	64a2                	ld	s1,8(sp)
}
 1ae:	854a                	mv	a0,s2
 1b0:	60e2                	ld	ra,24(sp)
 1b2:	6442                	ld	s0,16(sp)
 1b4:	6902                	ld	s2,0(sp)
 1b6:	6105                	addi	sp,sp,32
 1b8:	8082                	ret
    return -1;
 1ba:	597d                	li	s2,-1
 1bc:	bfcd                	j	1ae <stat+0x2a>

00000000000001be <atoi>:

int
atoi(const char *s)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e422                	sd	s0,8(sp)
 1c2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c4:	00054683          	lbu	a3,0(a0)
 1c8:	fd06879b          	addiw	a5,a3,-48
 1cc:	0ff7f793          	zext.b	a5,a5
 1d0:	4625                	li	a2,9
 1d2:	02f66863          	bltu	a2,a5,202 <atoi+0x44>
 1d6:	872a                	mv	a4,a0
  n = 0;
 1d8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1da:	0705                	addi	a4,a4,1
 1dc:	0025179b          	slliw	a5,a0,0x2
 1e0:	9fa9                	addw	a5,a5,a0
 1e2:	0017979b          	slliw	a5,a5,0x1
 1e6:	9fb5                	addw	a5,a5,a3
 1e8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1ec:	00074683          	lbu	a3,0(a4)
 1f0:	fd06879b          	addiw	a5,a3,-48
 1f4:	0ff7f793          	zext.b	a5,a5
 1f8:	fef671e3          	bgeu	a2,a5,1da <atoi+0x1c>
  return n;
}
 1fc:	6422                	ld	s0,8(sp)
 1fe:	0141                	addi	sp,sp,16
 200:	8082                	ret
  n = 0;
 202:	4501                	li	a0,0
 204:	bfe5                	j	1fc <atoi+0x3e>

0000000000000206 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 206:	1141                	addi	sp,sp,-16
 208:	e422                	sd	s0,8(sp)
 20a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 20c:	02b57463          	bgeu	a0,a1,234 <memmove+0x2e>
    while(n-- > 0)
 210:	00c05f63          	blez	a2,22e <memmove+0x28>
 214:	1602                	slli	a2,a2,0x20
 216:	9201                	srli	a2,a2,0x20
 218:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 21c:	872a                	mv	a4,a0
      *dst++ = *src++;
 21e:	0585                	addi	a1,a1,1
 220:	0705                	addi	a4,a4,1
 222:	fff5c683          	lbu	a3,-1(a1)
 226:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 22a:	fef71ae3          	bne	a4,a5,21e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 22e:	6422                	ld	s0,8(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret
    dst += n;
 234:	00c50733          	add	a4,a0,a2
    src += n;
 238:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 23a:	fec05ae3          	blez	a2,22e <memmove+0x28>
 23e:	fff6079b          	addiw	a5,a2,-1
 242:	1782                	slli	a5,a5,0x20
 244:	9381                	srli	a5,a5,0x20
 246:	fff7c793          	not	a5,a5
 24a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 24c:	15fd                	addi	a1,a1,-1
 24e:	177d                	addi	a4,a4,-1
 250:	0005c683          	lbu	a3,0(a1)
 254:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 258:	fee79ae3          	bne	a5,a4,24c <memmove+0x46>
 25c:	bfc9                	j	22e <memmove+0x28>

000000000000025e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 264:	ca05                	beqz	a2,294 <memcmp+0x36>
 266:	fff6069b          	addiw	a3,a2,-1
 26a:	1682                	slli	a3,a3,0x20
 26c:	9281                	srli	a3,a3,0x20
 26e:	0685                	addi	a3,a3,1
 270:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 272:	00054783          	lbu	a5,0(a0)
 276:	0005c703          	lbu	a4,0(a1)
 27a:	00e79863          	bne	a5,a4,28a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 27e:	0505                	addi	a0,a0,1
    p2++;
 280:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 282:	fed518e3          	bne	a0,a3,272 <memcmp+0x14>
  }
  return 0;
 286:	4501                	li	a0,0
 288:	a019                	j	28e <memcmp+0x30>
      return *p1 - *p2;
 28a:	40e7853b          	subw	a0,a5,a4
}
 28e:	6422                	ld	s0,8(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret
  return 0;
 294:	4501                	li	a0,0
 296:	bfe5                	j	28e <memcmp+0x30>

0000000000000298 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e406                	sd	ra,8(sp)
 29c:	e022                	sd	s0,0(sp)
 29e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a0:	f67ff0ef          	jal	206 <memmove>
}
 2a4:	60a2                	ld	ra,8(sp)
 2a6:	6402                	ld	s0,0(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret

00000000000002ac <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2ac:	4885                	li	a7,1
 ecall
 2ae:	00000073          	ecall
 ret
 2b2:	8082                	ret

00000000000002b4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2b4:	4889                	li	a7,2
 ecall
 2b6:	00000073          	ecall
 ret
 2ba:	8082                	ret

00000000000002bc <wait>:
.global wait
wait:
 li a7, SYS_wait
 2bc:	488d                	li	a7,3
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2c4:	4891                	li	a7,4
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <read>:
.global read
read:
 li a7, SYS_read
 2cc:	4895                	li	a7,5
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <write>:
.global write
write:
 li a7, SYS_write
 2d4:	48c1                	li	a7,16
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <close>:
.global close
close:
 li a7, SYS_close
 2dc:	48d5                	li	a7,21
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2e4:	4899                	li	a7,6
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <exec>:
.global exec
exec:
 li a7, SYS_exec
 2ec:	489d                	li	a7,7
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <open>:
.global open
open:
 li a7, SYS_open
 2f4:	48bd                	li	a7,15
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2fc:	48c5                	li	a7,17
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 304:	48c9                	li	a7,18
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 30c:	48a1                	li	a7,8
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <link>:
.global link
link:
 li a7, SYS_link
 314:	48cd                	li	a7,19
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 31c:	48d1                	li	a7,20
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 324:	48a5                	li	a7,9
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <dup>:
.global dup
dup:
 li a7, SYS_dup
 32c:	48a9                	li	a7,10
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 334:	48ad                	li	a7,11
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 33c:	48b1                	li	a7,12
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 344:	48b5                	li	a7,13
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 34c:	48b9                	li	a7,14
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 354:	1101                	addi	sp,sp,-32
 356:	ec06                	sd	ra,24(sp)
 358:	e822                	sd	s0,16(sp)
 35a:	1000                	addi	s0,sp,32
 35c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 360:	4605                	li	a2,1
 362:	fef40593          	addi	a1,s0,-17
 366:	f6fff0ef          	jal	2d4 <write>
}
 36a:	60e2                	ld	ra,24(sp)
 36c:	6442                	ld	s0,16(sp)
 36e:	6105                	addi	sp,sp,32
 370:	8082                	ret

0000000000000372 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 372:	7139                	addi	sp,sp,-64
 374:	fc06                	sd	ra,56(sp)
 376:	f822                	sd	s0,48(sp)
 378:	f426                	sd	s1,40(sp)
 37a:	0080                	addi	s0,sp,64
 37c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37e:	c299                	beqz	a3,384 <printint+0x12>
 380:	0805c963          	bltz	a1,412 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 384:	2581                	sext.w	a1,a1
  neg = 0;
 386:	4881                	li	a7,0
 388:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 38c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 38e:	2601                	sext.w	a2,a2
 390:	00000517          	auipc	a0,0x0
 394:	53850513          	addi	a0,a0,1336 # 8c8 <digits>
 398:	883a                	mv	a6,a4
 39a:	2705                	addiw	a4,a4,1
 39c:	02c5f7bb          	remuw	a5,a1,a2
 3a0:	1782                	slli	a5,a5,0x20
 3a2:	9381                	srli	a5,a5,0x20
 3a4:	97aa                	add	a5,a5,a0
 3a6:	0007c783          	lbu	a5,0(a5)
 3aa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3ae:	0005879b          	sext.w	a5,a1
 3b2:	02c5d5bb          	divuw	a1,a1,a2
 3b6:	0685                	addi	a3,a3,1
 3b8:	fec7f0e3          	bgeu	a5,a2,398 <printint+0x26>
  if(neg)
 3bc:	00088c63          	beqz	a7,3d4 <printint+0x62>
    buf[i++] = '-';
 3c0:	fd070793          	addi	a5,a4,-48
 3c4:	00878733          	add	a4,a5,s0
 3c8:	02d00793          	li	a5,45
 3cc:	fef70823          	sb	a5,-16(a4)
 3d0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3d4:	02e05a63          	blez	a4,408 <printint+0x96>
 3d8:	f04a                	sd	s2,32(sp)
 3da:	ec4e                	sd	s3,24(sp)
 3dc:	fc040793          	addi	a5,s0,-64
 3e0:	00e78933          	add	s2,a5,a4
 3e4:	fff78993          	addi	s3,a5,-1
 3e8:	99ba                	add	s3,s3,a4
 3ea:	377d                	addiw	a4,a4,-1
 3ec:	1702                	slli	a4,a4,0x20
 3ee:	9301                	srli	a4,a4,0x20
 3f0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 3f4:	fff94583          	lbu	a1,-1(s2)
 3f8:	8526                	mv	a0,s1
 3fa:	f5bff0ef          	jal	354 <putc>
  while(--i >= 0)
 3fe:	197d                	addi	s2,s2,-1
 400:	ff391ae3          	bne	s2,s3,3f4 <printint+0x82>
 404:	7902                	ld	s2,32(sp)
 406:	69e2                	ld	s3,24(sp)
}
 408:	70e2                	ld	ra,56(sp)
 40a:	7442                	ld	s0,48(sp)
 40c:	74a2                	ld	s1,40(sp)
 40e:	6121                	addi	sp,sp,64
 410:	8082                	ret
    x = -xx;
 412:	40b005bb          	negw	a1,a1
    neg = 1;
 416:	4885                	li	a7,1
    x = -xx;
 418:	bf85                	j	388 <printint+0x16>

000000000000041a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 41a:	711d                	addi	sp,sp,-96
 41c:	ec86                	sd	ra,88(sp)
 41e:	e8a2                	sd	s0,80(sp)
 420:	e0ca                	sd	s2,64(sp)
 422:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 424:	0005c903          	lbu	s2,0(a1)
 428:	26090863          	beqz	s2,698 <vprintf+0x27e>
 42c:	e4a6                	sd	s1,72(sp)
 42e:	fc4e                	sd	s3,56(sp)
 430:	f852                	sd	s4,48(sp)
 432:	f456                	sd	s5,40(sp)
 434:	f05a                	sd	s6,32(sp)
 436:	ec5e                	sd	s7,24(sp)
 438:	e862                	sd	s8,16(sp)
 43a:	e466                	sd	s9,8(sp)
 43c:	8b2a                	mv	s6,a0
 43e:	8a2e                	mv	s4,a1
 440:	8bb2                	mv	s7,a2
  state = 0;
 442:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 444:	4481                	li	s1,0
 446:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 448:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 44c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 450:	06c00c93          	li	s9,108
 454:	a005                	j	474 <vprintf+0x5a>
        putc(fd, c0);
 456:	85ca                	mv	a1,s2
 458:	855a                	mv	a0,s6
 45a:	efbff0ef          	jal	354 <putc>
 45e:	a019                	j	464 <vprintf+0x4a>
    } else if(state == '%'){
 460:	03598263          	beq	s3,s5,484 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 464:	2485                	addiw	s1,s1,1
 466:	8726                	mv	a4,s1
 468:	009a07b3          	add	a5,s4,s1
 46c:	0007c903          	lbu	s2,0(a5)
 470:	20090c63          	beqz	s2,688 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 474:	0009079b          	sext.w	a5,s2
    if(state == 0){
 478:	fe0994e3          	bnez	s3,460 <vprintf+0x46>
      if(c0 == '%'){
 47c:	fd579de3          	bne	a5,s5,456 <vprintf+0x3c>
        state = '%';
 480:	89be                	mv	s3,a5
 482:	b7cd                	j	464 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 484:	00ea06b3          	add	a3,s4,a4
 488:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 48c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 48e:	c681                	beqz	a3,496 <vprintf+0x7c>
 490:	9752                	add	a4,a4,s4
 492:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 496:	03878f63          	beq	a5,s8,4d4 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 49a:	05978963          	beq	a5,s9,4ec <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 49e:	07500713          	li	a4,117
 4a2:	0ee78363          	beq	a5,a4,588 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4a6:	07800713          	li	a4,120
 4aa:	12e78563          	beq	a5,a4,5d4 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4ae:	07000713          	li	a4,112
 4b2:	14e78a63          	beq	a5,a4,606 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 4b6:	07300713          	li	a4,115
 4ba:	18e78a63          	beq	a5,a4,64e <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 4be:	02500713          	li	a4,37
 4c2:	04e79563          	bne	a5,a4,50c <vprintf+0xf2>
        putc(fd, '%');
 4c6:	02500593          	li	a1,37
 4ca:	855a                	mv	a0,s6
 4cc:	e89ff0ef          	jal	354 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 4d0:	4981                	li	s3,0
 4d2:	bf49                	j	464 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 4d4:	008b8913          	addi	s2,s7,8
 4d8:	4685                	li	a3,1
 4da:	4629                	li	a2,10
 4dc:	000ba583          	lw	a1,0(s7)
 4e0:	855a                	mv	a0,s6
 4e2:	e91ff0ef          	jal	372 <printint>
 4e6:	8bca                	mv	s7,s2
      state = 0;
 4e8:	4981                	li	s3,0
 4ea:	bfad                	j	464 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 4ec:	06400793          	li	a5,100
 4f0:	02f68963          	beq	a3,a5,522 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 4f4:	06c00793          	li	a5,108
 4f8:	04f68263          	beq	a3,a5,53c <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 4fc:	07500793          	li	a5,117
 500:	0af68063          	beq	a3,a5,5a0 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 504:	07800793          	li	a5,120
 508:	0ef68263          	beq	a3,a5,5ec <vprintf+0x1d2>
        putc(fd, '%');
 50c:	02500593          	li	a1,37
 510:	855a                	mv	a0,s6
 512:	e43ff0ef          	jal	354 <putc>
        putc(fd, c0);
 516:	85ca                	mv	a1,s2
 518:	855a                	mv	a0,s6
 51a:	e3bff0ef          	jal	354 <putc>
      state = 0;
 51e:	4981                	li	s3,0
 520:	b791                	j	464 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 522:	008b8913          	addi	s2,s7,8
 526:	4685                	li	a3,1
 528:	4629                	li	a2,10
 52a:	000ba583          	lw	a1,0(s7)
 52e:	855a                	mv	a0,s6
 530:	e43ff0ef          	jal	372 <printint>
        i += 1;
 534:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 536:	8bca                	mv	s7,s2
      state = 0;
 538:	4981                	li	s3,0
        i += 1;
 53a:	b72d                	j	464 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 53c:	06400793          	li	a5,100
 540:	02f60763          	beq	a2,a5,56e <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 544:	07500793          	li	a5,117
 548:	06f60963          	beq	a2,a5,5ba <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 54c:	07800793          	li	a5,120
 550:	faf61ee3          	bne	a2,a5,50c <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 554:	008b8913          	addi	s2,s7,8
 558:	4681                	li	a3,0
 55a:	4641                	li	a2,16
 55c:	000ba583          	lw	a1,0(s7)
 560:	855a                	mv	a0,s6
 562:	e11ff0ef          	jal	372 <printint>
        i += 2;
 566:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 568:	8bca                	mv	s7,s2
      state = 0;
 56a:	4981                	li	s3,0
        i += 2;
 56c:	bde5                	j	464 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 56e:	008b8913          	addi	s2,s7,8
 572:	4685                	li	a3,1
 574:	4629                	li	a2,10
 576:	000ba583          	lw	a1,0(s7)
 57a:	855a                	mv	a0,s6
 57c:	df7ff0ef          	jal	372 <printint>
        i += 2;
 580:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 582:	8bca                	mv	s7,s2
      state = 0;
 584:	4981                	li	s3,0
        i += 2;
 586:	bdf9                	j	464 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 588:	008b8913          	addi	s2,s7,8
 58c:	4681                	li	a3,0
 58e:	4629                	li	a2,10
 590:	000ba583          	lw	a1,0(s7)
 594:	855a                	mv	a0,s6
 596:	dddff0ef          	jal	372 <printint>
 59a:	8bca                	mv	s7,s2
      state = 0;
 59c:	4981                	li	s3,0
 59e:	b5d9                	j	464 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5a0:	008b8913          	addi	s2,s7,8
 5a4:	4681                	li	a3,0
 5a6:	4629                	li	a2,10
 5a8:	000ba583          	lw	a1,0(s7)
 5ac:	855a                	mv	a0,s6
 5ae:	dc5ff0ef          	jal	372 <printint>
        i += 1;
 5b2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5b4:	8bca                	mv	s7,s2
      state = 0;
 5b6:	4981                	li	s3,0
        i += 1;
 5b8:	b575                	j	464 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ba:	008b8913          	addi	s2,s7,8
 5be:	4681                	li	a3,0
 5c0:	4629                	li	a2,10
 5c2:	000ba583          	lw	a1,0(s7)
 5c6:	855a                	mv	a0,s6
 5c8:	dabff0ef          	jal	372 <printint>
        i += 2;
 5cc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ce:	8bca                	mv	s7,s2
      state = 0;
 5d0:	4981                	li	s3,0
        i += 2;
 5d2:	bd49                	j	464 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 5d4:	008b8913          	addi	s2,s7,8
 5d8:	4681                	li	a3,0
 5da:	4641                	li	a2,16
 5dc:	000ba583          	lw	a1,0(s7)
 5e0:	855a                	mv	a0,s6
 5e2:	d91ff0ef          	jal	372 <printint>
 5e6:	8bca                	mv	s7,s2
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	bdad                	j	464 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5ec:	008b8913          	addi	s2,s7,8
 5f0:	4681                	li	a3,0
 5f2:	4641                	li	a2,16
 5f4:	000ba583          	lw	a1,0(s7)
 5f8:	855a                	mv	a0,s6
 5fa:	d79ff0ef          	jal	372 <printint>
        i += 1;
 5fe:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 600:	8bca                	mv	s7,s2
      state = 0;
 602:	4981                	li	s3,0
        i += 1;
 604:	b585                	j	464 <vprintf+0x4a>
 606:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 608:	008b8d13          	addi	s10,s7,8
 60c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 610:	03000593          	li	a1,48
 614:	855a                	mv	a0,s6
 616:	d3fff0ef          	jal	354 <putc>
  putc(fd, 'x');
 61a:	07800593          	li	a1,120
 61e:	855a                	mv	a0,s6
 620:	d35ff0ef          	jal	354 <putc>
 624:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 626:	00000b97          	auipc	s7,0x0
 62a:	2a2b8b93          	addi	s7,s7,674 # 8c8 <digits>
 62e:	03c9d793          	srli	a5,s3,0x3c
 632:	97de                	add	a5,a5,s7
 634:	0007c583          	lbu	a1,0(a5)
 638:	855a                	mv	a0,s6
 63a:	d1bff0ef          	jal	354 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 63e:	0992                	slli	s3,s3,0x4
 640:	397d                	addiw	s2,s2,-1
 642:	fe0916e3          	bnez	s2,62e <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 646:	8bea                	mv	s7,s10
      state = 0;
 648:	4981                	li	s3,0
 64a:	6d02                	ld	s10,0(sp)
 64c:	bd21                	j	464 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 64e:	008b8993          	addi	s3,s7,8
 652:	000bb903          	ld	s2,0(s7)
 656:	00090f63          	beqz	s2,674 <vprintf+0x25a>
        for(; *s; s++)
 65a:	00094583          	lbu	a1,0(s2)
 65e:	c195                	beqz	a1,682 <vprintf+0x268>
          putc(fd, *s);
 660:	855a                	mv	a0,s6
 662:	cf3ff0ef          	jal	354 <putc>
        for(; *s; s++)
 666:	0905                	addi	s2,s2,1
 668:	00094583          	lbu	a1,0(s2)
 66c:	f9f5                	bnez	a1,660 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 66e:	8bce                	mv	s7,s3
      state = 0;
 670:	4981                	li	s3,0
 672:	bbcd                	j	464 <vprintf+0x4a>
          s = "(null)";
 674:	00000917          	auipc	s2,0x0
 678:	24c90913          	addi	s2,s2,588 # 8c0 <malloc+0x140>
        for(; *s; s++)
 67c:	02800593          	li	a1,40
 680:	b7c5                	j	660 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 682:	8bce                	mv	s7,s3
      state = 0;
 684:	4981                	li	s3,0
 686:	bbf9                	j	464 <vprintf+0x4a>
 688:	64a6                	ld	s1,72(sp)
 68a:	79e2                	ld	s3,56(sp)
 68c:	7a42                	ld	s4,48(sp)
 68e:	7aa2                	ld	s5,40(sp)
 690:	7b02                	ld	s6,32(sp)
 692:	6be2                	ld	s7,24(sp)
 694:	6c42                	ld	s8,16(sp)
 696:	6ca2                	ld	s9,8(sp)
    }
  }
}
 698:	60e6                	ld	ra,88(sp)
 69a:	6446                	ld	s0,80(sp)
 69c:	6906                	ld	s2,64(sp)
 69e:	6125                	addi	sp,sp,96
 6a0:	8082                	ret

00000000000006a2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6a2:	715d                	addi	sp,sp,-80
 6a4:	ec06                	sd	ra,24(sp)
 6a6:	e822                	sd	s0,16(sp)
 6a8:	1000                	addi	s0,sp,32
 6aa:	e010                	sd	a2,0(s0)
 6ac:	e414                	sd	a3,8(s0)
 6ae:	e818                	sd	a4,16(s0)
 6b0:	ec1c                	sd	a5,24(s0)
 6b2:	03043023          	sd	a6,32(s0)
 6b6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6ba:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6be:	8622                	mv	a2,s0
 6c0:	d5bff0ef          	jal	41a <vprintf>
}
 6c4:	60e2                	ld	ra,24(sp)
 6c6:	6442                	ld	s0,16(sp)
 6c8:	6161                	addi	sp,sp,80
 6ca:	8082                	ret

00000000000006cc <printf>:

void
printf(const char *fmt, ...)
{
 6cc:	711d                	addi	sp,sp,-96
 6ce:	ec06                	sd	ra,24(sp)
 6d0:	e822                	sd	s0,16(sp)
 6d2:	1000                	addi	s0,sp,32
 6d4:	e40c                	sd	a1,8(s0)
 6d6:	e810                	sd	a2,16(s0)
 6d8:	ec14                	sd	a3,24(s0)
 6da:	f018                	sd	a4,32(s0)
 6dc:	f41c                	sd	a5,40(s0)
 6de:	03043823          	sd	a6,48(s0)
 6e2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6e6:	00840613          	addi	a2,s0,8
 6ea:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6ee:	85aa                	mv	a1,a0
 6f0:	4505                	li	a0,1
 6f2:	d29ff0ef          	jal	41a <vprintf>
}
 6f6:	60e2                	ld	ra,24(sp)
 6f8:	6442                	ld	s0,16(sp)
 6fa:	6125                	addi	sp,sp,96
 6fc:	8082                	ret

00000000000006fe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6fe:	1141                	addi	sp,sp,-16
 700:	e422                	sd	s0,8(sp)
 702:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 704:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 708:	00001797          	auipc	a5,0x1
 70c:	8f87b783          	ld	a5,-1800(a5) # 1000 <freep>
 710:	a02d                	j	73a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 712:	4618                	lw	a4,8(a2)
 714:	9f2d                	addw	a4,a4,a1
 716:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 71a:	6398                	ld	a4,0(a5)
 71c:	6310                	ld	a2,0(a4)
 71e:	a83d                	j	75c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 720:	ff852703          	lw	a4,-8(a0)
 724:	9f31                	addw	a4,a4,a2
 726:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 728:	ff053683          	ld	a3,-16(a0)
 72c:	a091                	j	770 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72e:	6398                	ld	a4,0(a5)
 730:	00e7e463          	bltu	a5,a4,738 <free+0x3a>
 734:	00e6ea63          	bltu	a3,a4,748 <free+0x4a>
{
 738:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73a:	fed7fae3          	bgeu	a5,a3,72e <free+0x30>
 73e:	6398                	ld	a4,0(a5)
 740:	00e6e463          	bltu	a3,a4,748 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 744:	fee7eae3          	bltu	a5,a4,738 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 748:	ff852583          	lw	a1,-8(a0)
 74c:	6390                	ld	a2,0(a5)
 74e:	02059813          	slli	a6,a1,0x20
 752:	01c85713          	srli	a4,a6,0x1c
 756:	9736                	add	a4,a4,a3
 758:	fae60de3          	beq	a2,a4,712 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 75c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 760:	4790                	lw	a2,8(a5)
 762:	02061593          	slli	a1,a2,0x20
 766:	01c5d713          	srli	a4,a1,0x1c
 76a:	973e                	add	a4,a4,a5
 76c:	fae68ae3          	beq	a3,a4,720 <free+0x22>
    p->s.ptr = bp->s.ptr;
 770:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 772:	00001717          	auipc	a4,0x1
 776:	88f73723          	sd	a5,-1906(a4) # 1000 <freep>
}
 77a:	6422                	ld	s0,8(sp)
 77c:	0141                	addi	sp,sp,16
 77e:	8082                	ret

0000000000000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	7139                	addi	sp,sp,-64
 782:	fc06                	sd	ra,56(sp)
 784:	f822                	sd	s0,48(sp)
 786:	f426                	sd	s1,40(sp)
 788:	ec4e                	sd	s3,24(sp)
 78a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 78c:	02051493          	slli	s1,a0,0x20
 790:	9081                	srli	s1,s1,0x20
 792:	04bd                	addi	s1,s1,15
 794:	8091                	srli	s1,s1,0x4
 796:	0014899b          	addiw	s3,s1,1
 79a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 79c:	00001517          	auipc	a0,0x1
 7a0:	86453503          	ld	a0,-1948(a0) # 1000 <freep>
 7a4:	c915                	beqz	a0,7d8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7a8:	4798                	lw	a4,8(a5)
 7aa:	08977a63          	bgeu	a4,s1,83e <malloc+0xbe>
 7ae:	f04a                	sd	s2,32(sp)
 7b0:	e852                	sd	s4,16(sp)
 7b2:	e456                	sd	s5,8(sp)
 7b4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7b6:	8a4e                	mv	s4,s3
 7b8:	0009871b          	sext.w	a4,s3
 7bc:	6685                	lui	a3,0x1
 7be:	00d77363          	bgeu	a4,a3,7c4 <malloc+0x44>
 7c2:	6a05                	lui	s4,0x1
 7c4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7c8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7cc:	00001917          	auipc	s2,0x1
 7d0:	83490913          	addi	s2,s2,-1996 # 1000 <freep>
  if(p == (char*)-1)
 7d4:	5afd                	li	s5,-1
 7d6:	a081                	j	816 <malloc+0x96>
 7d8:	f04a                	sd	s2,32(sp)
 7da:	e852                	sd	s4,16(sp)
 7dc:	e456                	sd	s5,8(sp)
 7de:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 7e0:	00001797          	auipc	a5,0x1
 7e4:	83078793          	addi	a5,a5,-2000 # 1010 <base>
 7e8:	00001717          	auipc	a4,0x1
 7ec:	80f73c23          	sd	a5,-2024(a4) # 1000 <freep>
 7f0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7f2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7f6:	b7c1                	j	7b6 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 7f8:	6398                	ld	a4,0(a5)
 7fa:	e118                	sd	a4,0(a0)
 7fc:	a8a9                	j	856 <malloc+0xd6>
  hp->s.size = nu;
 7fe:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 802:	0541                	addi	a0,a0,16
 804:	efbff0ef          	jal	6fe <free>
  return freep;
 808:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 80c:	c12d                	beqz	a0,86e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 810:	4798                	lw	a4,8(a5)
 812:	02977263          	bgeu	a4,s1,836 <malloc+0xb6>
    if(p == freep)
 816:	00093703          	ld	a4,0(s2)
 81a:	853e                	mv	a0,a5
 81c:	fef719e3          	bne	a4,a5,80e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 820:	8552                	mv	a0,s4
 822:	b1bff0ef          	jal	33c <sbrk>
  if(p == (char*)-1)
 826:	fd551ce3          	bne	a0,s5,7fe <malloc+0x7e>
        return 0;
 82a:	4501                	li	a0,0
 82c:	7902                	ld	s2,32(sp)
 82e:	6a42                	ld	s4,16(sp)
 830:	6aa2                	ld	s5,8(sp)
 832:	6b02                	ld	s6,0(sp)
 834:	a03d                	j	862 <malloc+0xe2>
 836:	7902                	ld	s2,32(sp)
 838:	6a42                	ld	s4,16(sp)
 83a:	6aa2                	ld	s5,8(sp)
 83c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 83e:	fae48de3          	beq	s1,a4,7f8 <malloc+0x78>
        p->s.size -= nunits;
 842:	4137073b          	subw	a4,a4,s3
 846:	c798                	sw	a4,8(a5)
        p += p->s.size;
 848:	02071693          	slli	a3,a4,0x20
 84c:	01c6d713          	srli	a4,a3,0x1c
 850:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 852:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 856:	00000717          	auipc	a4,0x0
 85a:	7aa73523          	sd	a0,1962(a4) # 1000 <freep>
      return (void*)(p + 1);
 85e:	01078513          	addi	a0,a5,16
  }
}
 862:	70e2                	ld	ra,56(sp)
 864:	7442                	ld	s0,48(sp)
 866:	74a2                	ld	s1,40(sp)
 868:	69e2                	ld	s3,24(sp)
 86a:	6121                	addi	sp,sp,64
 86c:	8082                	ret
 86e:	7902                	ld	s2,32(sp)
 870:	6a42                	ld	s4,16(sp)
 872:	6aa2                	ld	s5,8(sp)
 874:	6b02                	ld	s6,0(sp)
 876:	b7f5                	j	862 <malloc+0xe2>
