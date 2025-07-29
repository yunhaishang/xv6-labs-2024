
user/_find：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getfilename>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
getfilename(char *path)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	24e000ef          	jal	25a <strlen>
  10:	1502                	slli	a0,a0,0x20
  12:	9101                	srli	a0,a0,0x20
  14:	9526                	add	a0,a0,s1
  16:	02f00713          	li	a4,47
  1a:	00956963          	bltu	a0,s1,2c <getfilename+0x2c>
  1e:	00054783          	lbu	a5,0(a0)
  22:	00e78563          	beq	a5,a4,2c <getfilename+0x2c>
  26:	157d                	addi	a0,a0,-1
  28:	fe957be3          	bgeu	a0,s1,1e <getfilename+0x1e>
    ;
  p++;

  return p;
}
  2c:	0505                	addi	a0,a0,1
  2e:	60e2                	ld	ra,24(sp)
  30:	6442                	ld	s0,16(sp)
  32:	64a2                	ld	s1,8(sp)
  34:	6105                	addi	sp,sp,32
  36:	8082                	ret

0000000000000038 <find>:

void
find(char* path, char* file)
{
  38:	d9010113          	addi	sp,sp,-624
  3c:	26113423          	sd	ra,616(sp)
  40:	26813023          	sd	s0,608(sp)
  44:	25213823          	sd	s2,592(sp)
  48:	25313423          	sd	s3,584(sp)
  4c:	1c80                	addi	s0,sp,624
  4e:	892a                	mv	s2,a0
  50:	89ae                	mv	s3,a1
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  52:	4581                	li	a1,0
  54:	456000ef          	jal	4aa <open>
  58:	04054c63          	bltz	a0,b0 <find+0x78>
  5c:	24913c23          	sd	s1,600(sp)
  60:	84aa                	mv	s1,a0
    fprintf(2, "find: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  62:	d9840593          	addi	a1,s0,-616
  66:	45c000ef          	jal	4c2 <fstat>
  6a:	04054c63          	bltz	a0,c2 <find+0x8a>
    fprintf(2, "find: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  6e:	da041783          	lh	a5,-608(s0)
  72:	4705                	li	a4,1
  74:	06e78d63          	beq	a5,a4,ee <find+0xb6>
  78:	37f9                	addiw	a5,a5,-2
  7a:	17c2                	slli	a5,a5,0x30
  7c:	93c1                	srli	a5,a5,0x30
  7e:	00f76963          	bltu	a4,a5,90 <find+0x58>
  case T_DEVICE:
  case T_FILE:
    if(strcmp(getfilename(path),file) == 0){
  82:	854a                	mv	a0,s2
  84:	f7dff0ef          	jal	0 <getfilename>
  88:	85ce                	mv	a1,s3
  8a:	1a4000ef          	jal	22e <strcmp>
  8e:	c921                	beqz	a0,de <find+0xa6>
      }
      find(buf, file);
    }
    break;
  }
  close(fd);
  90:	8526                	mv	a0,s1
  92:	400000ef          	jal	492 <close>
  96:	25813483          	ld	s1,600(sp)
}
  9a:	26813083          	ld	ra,616(sp)
  9e:	26013403          	ld	s0,608(sp)
  a2:	25013903          	ld	s2,592(sp)
  a6:	24813983          	ld	s3,584(sp)
  aa:	27010113          	addi	sp,sp,624
  ae:	8082                	ret
    fprintf(2, "find: cannot open %s\n", path);
  b0:	864a                	mv	a2,s2
  b2:	00001597          	auipc	a1,0x1
  b6:	97e58593          	addi	a1,a1,-1666 # a30 <malloc+0xfa>
  ba:	4509                	li	a0,2
  bc:	79c000ef          	jal	858 <fprintf>
    return;
  c0:	bfe9                	j	9a <find+0x62>
    fprintf(2, "find: cannot stat %s\n", path);
  c2:	864a                	mv	a2,s2
  c4:	00001597          	auipc	a1,0x1
  c8:	98c58593          	addi	a1,a1,-1652 # a50 <malloc+0x11a>
  cc:	4509                	li	a0,2
  ce:	78a000ef          	jal	858 <fprintf>
    close(fd);
  d2:	8526                	mv	a0,s1
  d4:	3be000ef          	jal	492 <close>
    return;
  d8:	25813483          	ld	s1,600(sp)
  dc:	bf7d                	j	9a <find+0x62>
      printf("%s\n", path);
  de:	85ca                	mv	a1,s2
  e0:	00001517          	auipc	a0,0x1
  e4:	98850513          	addi	a0,a0,-1656 # a68 <malloc+0x132>
  e8:	79a000ef          	jal	882 <printf>
  ec:	b755                	j	90 <find+0x58>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
  ee:	854a                	mv	a0,s2
  f0:	16a000ef          	jal	25a <strlen>
  f4:	2541                	addiw	a0,a0,16
  f6:	20000793          	li	a5,512
  fa:	00a7f963          	bgeu	a5,a0,10c <find+0xd4>
      printf("find: path too long\n");
  fe:	00001517          	auipc	a0,0x1
 102:	97250513          	addi	a0,a0,-1678 # a70 <malloc+0x13a>
 106:	77c000ef          	jal	882 <printf>
      break;
 10a:	b759                	j	90 <find+0x58>
 10c:	25413023          	sd	s4,576(sp)
 110:	23513c23          	sd	s5,568(sp)
 114:	23613823          	sd	s6,560(sp)
    strcpy(buf, path);
 118:	85ca                	mv	a1,s2
 11a:	dc040513          	addi	a0,s0,-576
 11e:	0f4000ef          	jal	212 <strcpy>
    p = buf+strlen(buf);
 122:	dc040513          	addi	a0,s0,-576
 126:	134000ef          	jal	25a <strlen>
 12a:	1502                	slli	a0,a0,0x20
 12c:	9101                	srli	a0,a0,0x20
 12e:	dc040793          	addi	a5,s0,-576
 132:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 136:	00190b13          	addi	s6,s2,1
 13a:	02f00793          	li	a5,47
 13e:	00f90023          	sb	a5,0(s2)
      if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0){
 142:	00001a17          	auipc	s4,0x1
 146:	946a0a13          	addi	s4,s4,-1722 # a88 <malloc+0x152>
 14a:	00001a97          	auipc	s5,0x1
 14e:	946a8a93          	addi	s5,s5,-1722 # a90 <malloc+0x15a>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 152:	4641                	li	a2,16
 154:	db040593          	addi	a1,s0,-592
 158:	8526                	mv	a0,s1
 15a:	328000ef          	jal	482 <read>
 15e:	47c1                	li	a5,16
 160:	06f51063          	bne	a0,a5,1c0 <find+0x188>
      if(de.inum == 0)
 164:	db045783          	lhu	a5,-592(s0)
 168:	d7ed                	beqz	a5,152 <find+0x11a>
      if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0){
 16a:	85d2                	mv	a1,s4
 16c:	db240513          	addi	a0,s0,-590
 170:	0be000ef          	jal	22e <strcmp>
 174:	dd79                	beqz	a0,152 <find+0x11a>
 176:	85d6                	mv	a1,s5
 178:	db240513          	addi	a0,s0,-590
 17c:	0b2000ef          	jal	22e <strcmp>
 180:	d969                	beqz	a0,152 <find+0x11a>
      memmove(p, de.name, DIRSIZ);
 182:	4639                	li	a2,14
 184:	db240593          	addi	a1,s0,-590
 188:	855a                	mv	a0,s6
 18a:	232000ef          	jal	3bc <memmove>
      p[DIRSIZ] = 0;
 18e:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 192:	d9840593          	addi	a1,s0,-616
 196:	dc040513          	addi	a0,s0,-576
 19a:	1a0000ef          	jal	33a <stat>
 19e:	00054863          	bltz	a0,1ae <find+0x176>
      find(buf, file);
 1a2:	85ce                	mv	a1,s3
 1a4:	dc040513          	addi	a0,s0,-576
 1a8:	e91ff0ef          	jal	38 <find>
 1ac:	b75d                	j	152 <find+0x11a>
        printf("find: cannot stat %s\n", buf);
 1ae:	dc040593          	addi	a1,s0,-576
 1b2:	00001517          	auipc	a0,0x1
 1b6:	89e50513          	addi	a0,a0,-1890 # a50 <malloc+0x11a>
 1ba:	6c8000ef          	jal	882 <printf>
        continue;
 1be:	bf51                	j	152 <find+0x11a>
 1c0:	24013a03          	ld	s4,576(sp)
 1c4:	23813a83          	ld	s5,568(sp)
 1c8:	23013b03          	ld	s6,560(sp)
 1cc:	b5d1                	j	90 <find+0x58>

00000000000001ce <main>:

int
main(int argc, char *argv[])
{
 1ce:	1141                	addi	sp,sp,-16
 1d0:	e406                	sd	ra,8(sp)
 1d2:	e022                	sd	s0,0(sp)
 1d4:	0800                	addi	s0,sp,16
  if(argc < 3){
 1d6:	4709                	li	a4,2
 1d8:	00a74c63          	blt	a4,a0,1f0 <main+0x22>
    fprintf(2, "usage: find <root> <file>\n");
 1dc:	00001597          	auipc	a1,0x1
 1e0:	8bc58593          	addi	a1,a1,-1860 # a98 <malloc+0x162>
 1e4:	4509                	li	a0,2
 1e6:	672000ef          	jal	858 <fprintf>
    exit(1);
 1ea:	4505                	li	a0,1
 1ec:	27e000ef          	jal	46a <exit>
 1f0:	87ae                	mv	a5,a1
  }

  find(argv[1], argv[2]);
 1f2:	698c                	ld	a1,16(a1)
 1f4:	6788                	ld	a0,8(a5)
 1f6:	e43ff0ef          	jal	38 <find>

  exit(0);
 1fa:	4501                	li	a0,0
 1fc:	26e000ef          	jal	46a <exit>

0000000000000200 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 200:	1141                	addi	sp,sp,-16
 202:	e406                	sd	ra,8(sp)
 204:	e022                	sd	s0,0(sp)
 206:	0800                	addi	s0,sp,16
  extern int main();
  main();
 208:	fc7ff0ef          	jal	1ce <main>
  exit(0);
 20c:	4501                	li	a0,0
 20e:	25c000ef          	jal	46a <exit>

0000000000000212 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 212:	1141                	addi	sp,sp,-16
 214:	e422                	sd	s0,8(sp)
 216:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 218:	87aa                	mv	a5,a0
 21a:	0585                	addi	a1,a1,1
 21c:	0785                	addi	a5,a5,1
 21e:	fff5c703          	lbu	a4,-1(a1)
 222:	fee78fa3          	sb	a4,-1(a5)
 226:	fb75                	bnez	a4,21a <strcpy+0x8>
    ;
  return os;
}
 228:	6422                	ld	s0,8(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret

000000000000022e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 234:	00054783          	lbu	a5,0(a0)
 238:	cb91                	beqz	a5,24c <strcmp+0x1e>
 23a:	0005c703          	lbu	a4,0(a1)
 23e:	00f71763          	bne	a4,a5,24c <strcmp+0x1e>
    p++, q++;
 242:	0505                	addi	a0,a0,1
 244:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 246:	00054783          	lbu	a5,0(a0)
 24a:	fbe5                	bnez	a5,23a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 24c:	0005c503          	lbu	a0,0(a1)
}
 250:	40a7853b          	subw	a0,a5,a0
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret

000000000000025a <strlen>:

uint
strlen(const char *s)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 260:	00054783          	lbu	a5,0(a0)
 264:	cf91                	beqz	a5,280 <strlen+0x26>
 266:	0505                	addi	a0,a0,1
 268:	87aa                	mv	a5,a0
 26a:	86be                	mv	a3,a5
 26c:	0785                	addi	a5,a5,1
 26e:	fff7c703          	lbu	a4,-1(a5)
 272:	ff65                	bnez	a4,26a <strlen+0x10>
 274:	40a6853b          	subw	a0,a3,a0
 278:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret
  for(n = 0; s[n]; n++)
 280:	4501                	li	a0,0
 282:	bfe5                	j	27a <strlen+0x20>

0000000000000284 <memset>:

void*
memset(void *dst, int c, uint n)
{
 284:	1141                	addi	sp,sp,-16
 286:	e422                	sd	s0,8(sp)
 288:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 28a:	ca19                	beqz	a2,2a0 <memset+0x1c>
 28c:	87aa                	mv	a5,a0
 28e:	1602                	slli	a2,a2,0x20
 290:	9201                	srli	a2,a2,0x20
 292:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 296:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 29a:	0785                	addi	a5,a5,1
 29c:	fee79de3          	bne	a5,a4,296 <memset+0x12>
  }
  return dst;
}
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret

00000000000002a6 <strchr>:

char*
strchr(const char *s, char c)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2ac:	00054783          	lbu	a5,0(a0)
 2b0:	cb99                	beqz	a5,2c6 <strchr+0x20>
    if(*s == c)
 2b2:	00f58763          	beq	a1,a5,2c0 <strchr+0x1a>
  for(; *s; s++)
 2b6:	0505                	addi	a0,a0,1
 2b8:	00054783          	lbu	a5,0(a0)
 2bc:	fbfd                	bnez	a5,2b2 <strchr+0xc>
      return (char*)s;
  return 0;
 2be:	4501                	li	a0,0
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret
  return 0;
 2c6:	4501                	li	a0,0
 2c8:	bfe5                	j	2c0 <strchr+0x1a>

00000000000002ca <gets>:

char*
gets(char *buf, int max)
{
 2ca:	711d                	addi	sp,sp,-96
 2cc:	ec86                	sd	ra,88(sp)
 2ce:	e8a2                	sd	s0,80(sp)
 2d0:	e4a6                	sd	s1,72(sp)
 2d2:	e0ca                	sd	s2,64(sp)
 2d4:	fc4e                	sd	s3,56(sp)
 2d6:	f852                	sd	s4,48(sp)
 2d8:	f456                	sd	s5,40(sp)
 2da:	f05a                	sd	s6,32(sp)
 2dc:	ec5e                	sd	s7,24(sp)
 2de:	1080                	addi	s0,sp,96
 2e0:	8baa                	mv	s7,a0
 2e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e4:	892a                	mv	s2,a0
 2e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2e8:	4aa9                	li	s5,10
 2ea:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2ec:	89a6                	mv	s3,s1
 2ee:	2485                	addiw	s1,s1,1
 2f0:	0344d663          	bge	s1,s4,31c <gets+0x52>
    cc = read(0, &c, 1);
 2f4:	4605                	li	a2,1
 2f6:	faf40593          	addi	a1,s0,-81
 2fa:	4501                	li	a0,0
 2fc:	186000ef          	jal	482 <read>
    if(cc < 1)
 300:	00a05e63          	blez	a0,31c <gets+0x52>
    buf[i++] = c;
 304:	faf44783          	lbu	a5,-81(s0)
 308:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 30c:	01578763          	beq	a5,s5,31a <gets+0x50>
 310:	0905                	addi	s2,s2,1
 312:	fd679de3          	bne	a5,s6,2ec <gets+0x22>
    buf[i++] = c;
 316:	89a6                	mv	s3,s1
 318:	a011                	j	31c <gets+0x52>
 31a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 31c:	99de                	add	s3,s3,s7
 31e:	00098023          	sb	zero,0(s3)
  return buf;
}
 322:	855e                	mv	a0,s7
 324:	60e6                	ld	ra,88(sp)
 326:	6446                	ld	s0,80(sp)
 328:	64a6                	ld	s1,72(sp)
 32a:	6906                	ld	s2,64(sp)
 32c:	79e2                	ld	s3,56(sp)
 32e:	7a42                	ld	s4,48(sp)
 330:	7aa2                	ld	s5,40(sp)
 332:	7b02                	ld	s6,32(sp)
 334:	6be2                	ld	s7,24(sp)
 336:	6125                	addi	sp,sp,96
 338:	8082                	ret

000000000000033a <stat>:

int
stat(const char *n, struct stat *st)
{
 33a:	1101                	addi	sp,sp,-32
 33c:	ec06                	sd	ra,24(sp)
 33e:	e822                	sd	s0,16(sp)
 340:	e04a                	sd	s2,0(sp)
 342:	1000                	addi	s0,sp,32
 344:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 346:	4581                	li	a1,0
 348:	162000ef          	jal	4aa <open>
  if(fd < 0)
 34c:	02054263          	bltz	a0,370 <stat+0x36>
 350:	e426                	sd	s1,8(sp)
 352:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 354:	85ca                	mv	a1,s2
 356:	16c000ef          	jal	4c2 <fstat>
 35a:	892a                	mv	s2,a0
  close(fd);
 35c:	8526                	mv	a0,s1
 35e:	134000ef          	jal	492 <close>
  return r;
 362:	64a2                	ld	s1,8(sp)
}
 364:	854a                	mv	a0,s2
 366:	60e2                	ld	ra,24(sp)
 368:	6442                	ld	s0,16(sp)
 36a:	6902                	ld	s2,0(sp)
 36c:	6105                	addi	sp,sp,32
 36e:	8082                	ret
    return -1;
 370:	597d                	li	s2,-1
 372:	bfcd                	j	364 <stat+0x2a>

0000000000000374 <atoi>:

int
atoi(const char *s)
{
 374:	1141                	addi	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 37a:	00054683          	lbu	a3,0(a0)
 37e:	fd06879b          	addiw	a5,a3,-48
 382:	0ff7f793          	zext.b	a5,a5
 386:	4625                	li	a2,9
 388:	02f66863          	bltu	a2,a5,3b8 <atoi+0x44>
 38c:	872a                	mv	a4,a0
  n = 0;
 38e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 390:	0705                	addi	a4,a4,1
 392:	0025179b          	slliw	a5,a0,0x2
 396:	9fa9                	addw	a5,a5,a0
 398:	0017979b          	slliw	a5,a5,0x1
 39c:	9fb5                	addw	a5,a5,a3
 39e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3a2:	00074683          	lbu	a3,0(a4)
 3a6:	fd06879b          	addiw	a5,a3,-48
 3aa:	0ff7f793          	zext.b	a5,a5
 3ae:	fef671e3          	bgeu	a2,a5,390 <atoi+0x1c>
  return n;
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	addi	sp,sp,16
 3b6:	8082                	ret
  n = 0;
 3b8:	4501                	li	a0,0
 3ba:	bfe5                	j	3b2 <atoi+0x3e>

00000000000003bc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3bc:	1141                	addi	sp,sp,-16
 3be:	e422                	sd	s0,8(sp)
 3c0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3c2:	02b57463          	bgeu	a0,a1,3ea <memmove+0x2e>
    while(n-- > 0)
 3c6:	00c05f63          	blez	a2,3e4 <memmove+0x28>
 3ca:	1602                	slli	a2,a2,0x20
 3cc:	9201                	srli	a2,a2,0x20
 3ce:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3d2:	872a                	mv	a4,a0
      *dst++ = *src++;
 3d4:	0585                	addi	a1,a1,1
 3d6:	0705                	addi	a4,a4,1
 3d8:	fff5c683          	lbu	a3,-1(a1)
 3dc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3e0:	fef71ae3          	bne	a4,a5,3d4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3e4:	6422                	ld	s0,8(sp)
 3e6:	0141                	addi	sp,sp,16
 3e8:	8082                	ret
    dst += n;
 3ea:	00c50733          	add	a4,a0,a2
    src += n;
 3ee:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3f0:	fec05ae3          	blez	a2,3e4 <memmove+0x28>
 3f4:	fff6079b          	addiw	a5,a2,-1
 3f8:	1782                	slli	a5,a5,0x20
 3fa:	9381                	srli	a5,a5,0x20
 3fc:	fff7c793          	not	a5,a5
 400:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 402:	15fd                	addi	a1,a1,-1
 404:	177d                	addi	a4,a4,-1
 406:	0005c683          	lbu	a3,0(a1)
 40a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 40e:	fee79ae3          	bne	a5,a4,402 <memmove+0x46>
 412:	bfc9                	j	3e4 <memmove+0x28>

0000000000000414 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 414:	1141                	addi	sp,sp,-16
 416:	e422                	sd	s0,8(sp)
 418:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 41a:	ca05                	beqz	a2,44a <memcmp+0x36>
 41c:	fff6069b          	addiw	a3,a2,-1
 420:	1682                	slli	a3,a3,0x20
 422:	9281                	srli	a3,a3,0x20
 424:	0685                	addi	a3,a3,1
 426:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 428:	00054783          	lbu	a5,0(a0)
 42c:	0005c703          	lbu	a4,0(a1)
 430:	00e79863          	bne	a5,a4,440 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 434:	0505                	addi	a0,a0,1
    p2++;
 436:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 438:	fed518e3          	bne	a0,a3,428 <memcmp+0x14>
  }
  return 0;
 43c:	4501                	li	a0,0
 43e:	a019                	j	444 <memcmp+0x30>
      return *p1 - *p2;
 440:	40e7853b          	subw	a0,a5,a4
}
 444:	6422                	ld	s0,8(sp)
 446:	0141                	addi	sp,sp,16
 448:	8082                	ret
  return 0;
 44a:	4501                	li	a0,0
 44c:	bfe5                	j	444 <memcmp+0x30>

000000000000044e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 44e:	1141                	addi	sp,sp,-16
 450:	e406                	sd	ra,8(sp)
 452:	e022                	sd	s0,0(sp)
 454:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 456:	f67ff0ef          	jal	3bc <memmove>
}
 45a:	60a2                	ld	ra,8(sp)
 45c:	6402                	ld	s0,0(sp)
 45e:	0141                	addi	sp,sp,16
 460:	8082                	ret

0000000000000462 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 462:	4885                	li	a7,1
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <exit>:
.global exit
exit:
 li a7, SYS_exit
 46a:	4889                	li	a7,2
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <wait>:
.global wait
wait:
 li a7, SYS_wait
 472:	488d                	li	a7,3
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 47a:	4891                	li	a7,4
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <read>:
.global read
read:
 li a7, SYS_read
 482:	4895                	li	a7,5
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <write>:
.global write
write:
 li a7, SYS_write
 48a:	48c1                	li	a7,16
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <close>:
.global close
close:
 li a7, SYS_close
 492:	48d5                	li	a7,21
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <kill>:
.global kill
kill:
 li a7, SYS_kill
 49a:	4899                	li	a7,6
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4a2:	489d                	li	a7,7
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <open>:
.global open
open:
 li a7, SYS_open
 4aa:	48bd                	li	a7,15
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4b2:	48c5                	li	a7,17
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4ba:	48c9                	li	a7,18
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4c2:	48a1                	li	a7,8
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <link>:
.global link
link:
 li a7, SYS_link
 4ca:	48cd                	li	a7,19
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4d2:	48d1                	li	a7,20
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4da:	48a5                	li	a7,9
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4e2:	48a9                	li	a7,10
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4ea:	48ad                	li	a7,11
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4f2:	48b1                	li	a7,12
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4fa:	48b5                	li	a7,13
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 502:	48b9                	li	a7,14
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 50a:	1101                	addi	sp,sp,-32
 50c:	ec06                	sd	ra,24(sp)
 50e:	e822                	sd	s0,16(sp)
 510:	1000                	addi	s0,sp,32
 512:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 516:	4605                	li	a2,1
 518:	fef40593          	addi	a1,s0,-17
 51c:	f6fff0ef          	jal	48a <write>
}
 520:	60e2                	ld	ra,24(sp)
 522:	6442                	ld	s0,16(sp)
 524:	6105                	addi	sp,sp,32
 526:	8082                	ret

0000000000000528 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 528:	7139                	addi	sp,sp,-64
 52a:	fc06                	sd	ra,56(sp)
 52c:	f822                	sd	s0,48(sp)
 52e:	f426                	sd	s1,40(sp)
 530:	0080                	addi	s0,sp,64
 532:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 534:	c299                	beqz	a3,53a <printint+0x12>
 536:	0805c963          	bltz	a1,5c8 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 53a:	2581                	sext.w	a1,a1
  neg = 0;
 53c:	4881                	li	a7,0
 53e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 542:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 544:	2601                	sext.w	a2,a2
 546:	00000517          	auipc	a0,0x0
 54a:	57a50513          	addi	a0,a0,1402 # ac0 <digits>
 54e:	883a                	mv	a6,a4
 550:	2705                	addiw	a4,a4,1
 552:	02c5f7bb          	remuw	a5,a1,a2
 556:	1782                	slli	a5,a5,0x20
 558:	9381                	srli	a5,a5,0x20
 55a:	97aa                	add	a5,a5,a0
 55c:	0007c783          	lbu	a5,0(a5)
 560:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 564:	0005879b          	sext.w	a5,a1
 568:	02c5d5bb          	divuw	a1,a1,a2
 56c:	0685                	addi	a3,a3,1
 56e:	fec7f0e3          	bgeu	a5,a2,54e <printint+0x26>
  if(neg)
 572:	00088c63          	beqz	a7,58a <printint+0x62>
    buf[i++] = '-';
 576:	fd070793          	addi	a5,a4,-48
 57a:	00878733          	add	a4,a5,s0
 57e:	02d00793          	li	a5,45
 582:	fef70823          	sb	a5,-16(a4)
 586:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 58a:	02e05a63          	blez	a4,5be <printint+0x96>
 58e:	f04a                	sd	s2,32(sp)
 590:	ec4e                	sd	s3,24(sp)
 592:	fc040793          	addi	a5,s0,-64
 596:	00e78933          	add	s2,a5,a4
 59a:	fff78993          	addi	s3,a5,-1
 59e:	99ba                	add	s3,s3,a4
 5a0:	377d                	addiw	a4,a4,-1
 5a2:	1702                	slli	a4,a4,0x20
 5a4:	9301                	srli	a4,a4,0x20
 5a6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5aa:	fff94583          	lbu	a1,-1(s2)
 5ae:	8526                	mv	a0,s1
 5b0:	f5bff0ef          	jal	50a <putc>
  while(--i >= 0)
 5b4:	197d                	addi	s2,s2,-1
 5b6:	ff391ae3          	bne	s2,s3,5aa <printint+0x82>
 5ba:	7902                	ld	s2,32(sp)
 5bc:	69e2                	ld	s3,24(sp)
}
 5be:	70e2                	ld	ra,56(sp)
 5c0:	7442                	ld	s0,48(sp)
 5c2:	74a2                	ld	s1,40(sp)
 5c4:	6121                	addi	sp,sp,64
 5c6:	8082                	ret
    x = -xx;
 5c8:	40b005bb          	negw	a1,a1
    neg = 1;
 5cc:	4885                	li	a7,1
    x = -xx;
 5ce:	bf85                	j	53e <printint+0x16>

00000000000005d0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5d0:	711d                	addi	sp,sp,-96
 5d2:	ec86                	sd	ra,88(sp)
 5d4:	e8a2                	sd	s0,80(sp)
 5d6:	e0ca                	sd	s2,64(sp)
 5d8:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5da:	0005c903          	lbu	s2,0(a1)
 5de:	26090863          	beqz	s2,84e <vprintf+0x27e>
 5e2:	e4a6                	sd	s1,72(sp)
 5e4:	fc4e                	sd	s3,56(sp)
 5e6:	f852                	sd	s4,48(sp)
 5e8:	f456                	sd	s5,40(sp)
 5ea:	f05a                	sd	s6,32(sp)
 5ec:	ec5e                	sd	s7,24(sp)
 5ee:	e862                	sd	s8,16(sp)
 5f0:	e466                	sd	s9,8(sp)
 5f2:	8b2a                	mv	s6,a0
 5f4:	8a2e                	mv	s4,a1
 5f6:	8bb2                	mv	s7,a2
  state = 0;
 5f8:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5fa:	4481                	li	s1,0
 5fc:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5fe:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 602:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 606:	06c00c93          	li	s9,108
 60a:	a005                	j	62a <vprintf+0x5a>
        putc(fd, c0);
 60c:	85ca                	mv	a1,s2
 60e:	855a                	mv	a0,s6
 610:	efbff0ef          	jal	50a <putc>
 614:	a019                	j	61a <vprintf+0x4a>
    } else if(state == '%'){
 616:	03598263          	beq	s3,s5,63a <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 61a:	2485                	addiw	s1,s1,1
 61c:	8726                	mv	a4,s1
 61e:	009a07b3          	add	a5,s4,s1
 622:	0007c903          	lbu	s2,0(a5)
 626:	20090c63          	beqz	s2,83e <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 62a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 62e:	fe0994e3          	bnez	s3,616 <vprintf+0x46>
      if(c0 == '%'){
 632:	fd579de3          	bne	a5,s5,60c <vprintf+0x3c>
        state = '%';
 636:	89be                	mv	s3,a5
 638:	b7cd                	j	61a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 63a:	00ea06b3          	add	a3,s4,a4
 63e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 642:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 644:	c681                	beqz	a3,64c <vprintf+0x7c>
 646:	9752                	add	a4,a4,s4
 648:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 64c:	03878f63          	beq	a5,s8,68a <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 650:	05978963          	beq	a5,s9,6a2 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 654:	07500713          	li	a4,117
 658:	0ee78363          	beq	a5,a4,73e <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 65c:	07800713          	li	a4,120
 660:	12e78563          	beq	a5,a4,78a <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 664:	07000713          	li	a4,112
 668:	14e78a63          	beq	a5,a4,7bc <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 66c:	07300713          	li	a4,115
 670:	18e78a63          	beq	a5,a4,804 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 674:	02500713          	li	a4,37
 678:	04e79563          	bne	a5,a4,6c2 <vprintf+0xf2>
        putc(fd, '%');
 67c:	02500593          	li	a1,37
 680:	855a                	mv	a0,s6
 682:	e89ff0ef          	jal	50a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 686:	4981                	li	s3,0
 688:	bf49                	j	61a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 68a:	008b8913          	addi	s2,s7,8
 68e:	4685                	li	a3,1
 690:	4629                	li	a2,10
 692:	000ba583          	lw	a1,0(s7)
 696:	855a                	mv	a0,s6
 698:	e91ff0ef          	jal	528 <printint>
 69c:	8bca                	mv	s7,s2
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	bfad                	j	61a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6a2:	06400793          	li	a5,100
 6a6:	02f68963          	beq	a3,a5,6d8 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6aa:	06c00793          	li	a5,108
 6ae:	04f68263          	beq	a3,a5,6f2 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 6b2:	07500793          	li	a5,117
 6b6:	0af68063          	beq	a3,a5,756 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 6ba:	07800793          	li	a5,120
 6be:	0ef68263          	beq	a3,a5,7a2 <vprintf+0x1d2>
        putc(fd, '%');
 6c2:	02500593          	li	a1,37
 6c6:	855a                	mv	a0,s6
 6c8:	e43ff0ef          	jal	50a <putc>
        putc(fd, c0);
 6cc:	85ca                	mv	a1,s2
 6ce:	855a                	mv	a0,s6
 6d0:	e3bff0ef          	jal	50a <putc>
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	b791                	j	61a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d8:	008b8913          	addi	s2,s7,8
 6dc:	4685                	li	a3,1
 6de:	4629                	li	a2,10
 6e0:	000ba583          	lw	a1,0(s7)
 6e4:	855a                	mv	a0,s6
 6e6:	e43ff0ef          	jal	528 <printint>
        i += 1;
 6ea:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ec:	8bca                	mv	s7,s2
      state = 0;
 6ee:	4981                	li	s3,0
        i += 1;
 6f0:	b72d                	j	61a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6f2:	06400793          	li	a5,100
 6f6:	02f60763          	beq	a2,a5,724 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6fa:	07500793          	li	a5,117
 6fe:	06f60963          	beq	a2,a5,770 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 702:	07800793          	li	a5,120
 706:	faf61ee3          	bne	a2,a5,6c2 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 70a:	008b8913          	addi	s2,s7,8
 70e:	4681                	li	a3,0
 710:	4641                	li	a2,16
 712:	000ba583          	lw	a1,0(s7)
 716:	855a                	mv	a0,s6
 718:	e11ff0ef          	jal	528 <printint>
        i += 2;
 71c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 71e:	8bca                	mv	s7,s2
      state = 0;
 720:	4981                	li	s3,0
        i += 2;
 722:	bde5                	j	61a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 724:	008b8913          	addi	s2,s7,8
 728:	4685                	li	a3,1
 72a:	4629                	li	a2,10
 72c:	000ba583          	lw	a1,0(s7)
 730:	855a                	mv	a0,s6
 732:	df7ff0ef          	jal	528 <printint>
        i += 2;
 736:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 738:	8bca                	mv	s7,s2
      state = 0;
 73a:	4981                	li	s3,0
        i += 2;
 73c:	bdf9                	j	61a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 73e:	008b8913          	addi	s2,s7,8
 742:	4681                	li	a3,0
 744:	4629                	li	a2,10
 746:	000ba583          	lw	a1,0(s7)
 74a:	855a                	mv	a0,s6
 74c:	dddff0ef          	jal	528 <printint>
 750:	8bca                	mv	s7,s2
      state = 0;
 752:	4981                	li	s3,0
 754:	b5d9                	j	61a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 756:	008b8913          	addi	s2,s7,8
 75a:	4681                	li	a3,0
 75c:	4629                	li	a2,10
 75e:	000ba583          	lw	a1,0(s7)
 762:	855a                	mv	a0,s6
 764:	dc5ff0ef          	jal	528 <printint>
        i += 1;
 768:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 76a:	8bca                	mv	s7,s2
      state = 0;
 76c:	4981                	li	s3,0
        i += 1;
 76e:	b575                	j	61a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 770:	008b8913          	addi	s2,s7,8
 774:	4681                	li	a3,0
 776:	4629                	li	a2,10
 778:	000ba583          	lw	a1,0(s7)
 77c:	855a                	mv	a0,s6
 77e:	dabff0ef          	jal	528 <printint>
        i += 2;
 782:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 784:	8bca                	mv	s7,s2
      state = 0;
 786:	4981                	li	s3,0
        i += 2;
 788:	bd49                	j	61a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 78a:	008b8913          	addi	s2,s7,8
 78e:	4681                	li	a3,0
 790:	4641                	li	a2,16
 792:	000ba583          	lw	a1,0(s7)
 796:	855a                	mv	a0,s6
 798:	d91ff0ef          	jal	528 <printint>
 79c:	8bca                	mv	s7,s2
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	bdad                	j	61a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7a2:	008b8913          	addi	s2,s7,8
 7a6:	4681                	li	a3,0
 7a8:	4641                	li	a2,16
 7aa:	000ba583          	lw	a1,0(s7)
 7ae:	855a                	mv	a0,s6
 7b0:	d79ff0ef          	jal	528 <printint>
        i += 1;
 7b4:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b6:	8bca                	mv	s7,s2
      state = 0;
 7b8:	4981                	li	s3,0
        i += 1;
 7ba:	b585                	j	61a <vprintf+0x4a>
 7bc:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7be:	008b8d13          	addi	s10,s7,8
 7c2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7c6:	03000593          	li	a1,48
 7ca:	855a                	mv	a0,s6
 7cc:	d3fff0ef          	jal	50a <putc>
  putc(fd, 'x');
 7d0:	07800593          	li	a1,120
 7d4:	855a                	mv	a0,s6
 7d6:	d35ff0ef          	jal	50a <putc>
 7da:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7dc:	00000b97          	auipc	s7,0x0
 7e0:	2e4b8b93          	addi	s7,s7,740 # ac0 <digits>
 7e4:	03c9d793          	srli	a5,s3,0x3c
 7e8:	97de                	add	a5,a5,s7
 7ea:	0007c583          	lbu	a1,0(a5)
 7ee:	855a                	mv	a0,s6
 7f0:	d1bff0ef          	jal	50a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7f4:	0992                	slli	s3,s3,0x4
 7f6:	397d                	addiw	s2,s2,-1
 7f8:	fe0916e3          	bnez	s2,7e4 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 7fc:	8bea                	mv	s7,s10
      state = 0;
 7fe:	4981                	li	s3,0
 800:	6d02                	ld	s10,0(sp)
 802:	bd21                	j	61a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 804:	008b8993          	addi	s3,s7,8
 808:	000bb903          	ld	s2,0(s7)
 80c:	00090f63          	beqz	s2,82a <vprintf+0x25a>
        for(; *s; s++)
 810:	00094583          	lbu	a1,0(s2)
 814:	c195                	beqz	a1,838 <vprintf+0x268>
          putc(fd, *s);
 816:	855a                	mv	a0,s6
 818:	cf3ff0ef          	jal	50a <putc>
        for(; *s; s++)
 81c:	0905                	addi	s2,s2,1
 81e:	00094583          	lbu	a1,0(s2)
 822:	f9f5                	bnez	a1,816 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 824:	8bce                	mv	s7,s3
      state = 0;
 826:	4981                	li	s3,0
 828:	bbcd                	j	61a <vprintf+0x4a>
          s = "(null)";
 82a:	00000917          	auipc	s2,0x0
 82e:	28e90913          	addi	s2,s2,654 # ab8 <malloc+0x182>
        for(; *s; s++)
 832:	02800593          	li	a1,40
 836:	b7c5                	j	816 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 838:	8bce                	mv	s7,s3
      state = 0;
 83a:	4981                	li	s3,0
 83c:	bbf9                	j	61a <vprintf+0x4a>
 83e:	64a6                	ld	s1,72(sp)
 840:	79e2                	ld	s3,56(sp)
 842:	7a42                	ld	s4,48(sp)
 844:	7aa2                	ld	s5,40(sp)
 846:	7b02                	ld	s6,32(sp)
 848:	6be2                	ld	s7,24(sp)
 84a:	6c42                	ld	s8,16(sp)
 84c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 84e:	60e6                	ld	ra,88(sp)
 850:	6446                	ld	s0,80(sp)
 852:	6906                	ld	s2,64(sp)
 854:	6125                	addi	sp,sp,96
 856:	8082                	ret

0000000000000858 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 858:	715d                	addi	sp,sp,-80
 85a:	ec06                	sd	ra,24(sp)
 85c:	e822                	sd	s0,16(sp)
 85e:	1000                	addi	s0,sp,32
 860:	e010                	sd	a2,0(s0)
 862:	e414                	sd	a3,8(s0)
 864:	e818                	sd	a4,16(s0)
 866:	ec1c                	sd	a5,24(s0)
 868:	03043023          	sd	a6,32(s0)
 86c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 870:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 874:	8622                	mv	a2,s0
 876:	d5bff0ef          	jal	5d0 <vprintf>
}
 87a:	60e2                	ld	ra,24(sp)
 87c:	6442                	ld	s0,16(sp)
 87e:	6161                	addi	sp,sp,80
 880:	8082                	ret

0000000000000882 <printf>:

void
printf(const char *fmt, ...)
{
 882:	711d                	addi	sp,sp,-96
 884:	ec06                	sd	ra,24(sp)
 886:	e822                	sd	s0,16(sp)
 888:	1000                	addi	s0,sp,32
 88a:	e40c                	sd	a1,8(s0)
 88c:	e810                	sd	a2,16(s0)
 88e:	ec14                	sd	a3,24(s0)
 890:	f018                	sd	a4,32(s0)
 892:	f41c                	sd	a5,40(s0)
 894:	03043823          	sd	a6,48(s0)
 898:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 89c:	00840613          	addi	a2,s0,8
 8a0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8a4:	85aa                	mv	a1,a0
 8a6:	4505                	li	a0,1
 8a8:	d29ff0ef          	jal	5d0 <vprintf>
}
 8ac:	60e2                	ld	ra,24(sp)
 8ae:	6442                	ld	s0,16(sp)
 8b0:	6125                	addi	sp,sp,96
 8b2:	8082                	ret

00000000000008b4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b4:	1141                	addi	sp,sp,-16
 8b6:	e422                	sd	s0,8(sp)
 8b8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ba:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8be:	00000797          	auipc	a5,0x0
 8c2:	7427b783          	ld	a5,1858(a5) # 1000 <freep>
 8c6:	a02d                	j	8f0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8c8:	4618                	lw	a4,8(a2)
 8ca:	9f2d                	addw	a4,a4,a1
 8cc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8d0:	6398                	ld	a4,0(a5)
 8d2:	6310                	ld	a2,0(a4)
 8d4:	a83d                	j	912 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8d6:	ff852703          	lw	a4,-8(a0)
 8da:	9f31                	addw	a4,a4,a2
 8dc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8de:	ff053683          	ld	a3,-16(a0)
 8e2:	a091                	j	926 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e4:	6398                	ld	a4,0(a5)
 8e6:	00e7e463          	bltu	a5,a4,8ee <free+0x3a>
 8ea:	00e6ea63          	bltu	a3,a4,8fe <free+0x4a>
{
 8ee:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f0:	fed7fae3          	bgeu	a5,a3,8e4 <free+0x30>
 8f4:	6398                	ld	a4,0(a5)
 8f6:	00e6e463          	bltu	a3,a4,8fe <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fa:	fee7eae3          	bltu	a5,a4,8ee <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8fe:	ff852583          	lw	a1,-8(a0)
 902:	6390                	ld	a2,0(a5)
 904:	02059813          	slli	a6,a1,0x20
 908:	01c85713          	srli	a4,a6,0x1c
 90c:	9736                	add	a4,a4,a3
 90e:	fae60de3          	beq	a2,a4,8c8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 912:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 916:	4790                	lw	a2,8(a5)
 918:	02061593          	slli	a1,a2,0x20
 91c:	01c5d713          	srli	a4,a1,0x1c
 920:	973e                	add	a4,a4,a5
 922:	fae68ae3          	beq	a3,a4,8d6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 926:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 928:	00000717          	auipc	a4,0x0
 92c:	6cf73c23          	sd	a5,1752(a4) # 1000 <freep>
}
 930:	6422                	ld	s0,8(sp)
 932:	0141                	addi	sp,sp,16
 934:	8082                	ret

0000000000000936 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 936:	7139                	addi	sp,sp,-64
 938:	fc06                	sd	ra,56(sp)
 93a:	f822                	sd	s0,48(sp)
 93c:	f426                	sd	s1,40(sp)
 93e:	ec4e                	sd	s3,24(sp)
 940:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 942:	02051493          	slli	s1,a0,0x20
 946:	9081                	srli	s1,s1,0x20
 948:	04bd                	addi	s1,s1,15
 94a:	8091                	srli	s1,s1,0x4
 94c:	0014899b          	addiw	s3,s1,1
 950:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 952:	00000517          	auipc	a0,0x0
 956:	6ae53503          	ld	a0,1710(a0) # 1000 <freep>
 95a:	c915                	beqz	a0,98e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 95c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 95e:	4798                	lw	a4,8(a5)
 960:	08977a63          	bgeu	a4,s1,9f4 <malloc+0xbe>
 964:	f04a                	sd	s2,32(sp)
 966:	e852                	sd	s4,16(sp)
 968:	e456                	sd	s5,8(sp)
 96a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 96c:	8a4e                	mv	s4,s3
 96e:	0009871b          	sext.w	a4,s3
 972:	6685                	lui	a3,0x1
 974:	00d77363          	bgeu	a4,a3,97a <malloc+0x44>
 978:	6a05                	lui	s4,0x1
 97a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 97e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 982:	00000917          	auipc	s2,0x0
 986:	67e90913          	addi	s2,s2,1662 # 1000 <freep>
  if(p == (char*)-1)
 98a:	5afd                	li	s5,-1
 98c:	a081                	j	9cc <malloc+0x96>
 98e:	f04a                	sd	s2,32(sp)
 990:	e852                	sd	s4,16(sp)
 992:	e456                	sd	s5,8(sp)
 994:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 996:	00000797          	auipc	a5,0x0
 99a:	67a78793          	addi	a5,a5,1658 # 1010 <base>
 99e:	00000717          	auipc	a4,0x0
 9a2:	66f73123          	sd	a5,1634(a4) # 1000 <freep>
 9a6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9a8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9ac:	b7c1                	j	96c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9ae:	6398                	ld	a4,0(a5)
 9b0:	e118                	sd	a4,0(a0)
 9b2:	a8a9                	j	a0c <malloc+0xd6>
  hp->s.size = nu;
 9b4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9b8:	0541                	addi	a0,a0,16
 9ba:	efbff0ef          	jal	8b4 <free>
  return freep;
 9be:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9c2:	c12d                	beqz	a0,a24 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9c6:	4798                	lw	a4,8(a5)
 9c8:	02977263          	bgeu	a4,s1,9ec <malloc+0xb6>
    if(p == freep)
 9cc:	00093703          	ld	a4,0(s2)
 9d0:	853e                	mv	a0,a5
 9d2:	fef719e3          	bne	a4,a5,9c4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9d6:	8552                	mv	a0,s4
 9d8:	b1bff0ef          	jal	4f2 <sbrk>
  if(p == (char*)-1)
 9dc:	fd551ce3          	bne	a0,s5,9b4 <malloc+0x7e>
        return 0;
 9e0:	4501                	li	a0,0
 9e2:	7902                	ld	s2,32(sp)
 9e4:	6a42                	ld	s4,16(sp)
 9e6:	6aa2                	ld	s5,8(sp)
 9e8:	6b02                	ld	s6,0(sp)
 9ea:	a03d                	j	a18 <malloc+0xe2>
 9ec:	7902                	ld	s2,32(sp)
 9ee:	6a42                	ld	s4,16(sp)
 9f0:	6aa2                	ld	s5,8(sp)
 9f2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9f4:	fae48de3          	beq	s1,a4,9ae <malloc+0x78>
        p->s.size -= nunits;
 9f8:	4137073b          	subw	a4,a4,s3
 9fc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9fe:	02071693          	slli	a3,a4,0x20
 a02:	01c6d713          	srli	a4,a3,0x1c
 a06:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a08:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a0c:	00000717          	auipc	a4,0x0
 a10:	5ea73a23          	sd	a0,1524(a4) # 1000 <freep>
      return (void*)(p + 1);
 a14:	01078513          	addi	a0,a5,16
  }
}
 a18:	70e2                	ld	ra,56(sp)
 a1a:	7442                	ld	s0,48(sp)
 a1c:	74a2                	ld	s1,40(sp)
 a1e:	69e2                	ld	s3,24(sp)
 a20:	6121                	addi	sp,sp,64
 a22:	8082                	ret
 a24:	7902                	ld	s2,32(sp)
 a26:	6a42                	ld	s4,16(sp)
 a28:	6aa2                	ld	s5,8(sp)
 a2a:	6b02                	ld	s6,0(sp)
 a2c:	b7f5                	j	a18 <malloc+0xe2>
