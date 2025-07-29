
user/_xargs：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

#define MAXARGLENGTH 64

int
main(int argc, char *argv[])
{
   0:	81010113          	addi	sp,sp,-2032
   4:	7e113423          	sd	ra,2024(sp)
   8:	7e813023          	sd	s0,2016(sp)
   c:	7c913c23          	sd	s1,2008(sp)
  10:	7d213823          	sd	s2,2000(sp)
  14:	7d313423          	sd	s3,1992(sp)
  18:	7d413023          	sd	s4,1984(sp)
  1c:	7b513c23          	sd	s5,1976(sp)
  20:	7b613823          	sd	s6,1968(sp)
  24:	7b713423          	sd	s7,1960(sp)
  28:	7f010413          	addi	s0,sp,2032
  2c:	ca010113          	addi	sp,sp,-864
  30:	89aa                	mv	s3,a0
  32:	8a2e                	mv	s4,a1
	int i; // 第i个参数
	int j = 0; // 第i个参数的第j个字母
	char buf[512];

	read(0, buf, 512);
  34:	20000613          	li	a2,512
  38:	db040593          	addi	a1,s0,-592
  3c:	4501                	li	a0,0
  3e:	3a8000ef          	jal	3e6 <read>

	int argc2 = argc - 1;
  42:	fff98b1b          	addiw	s6,s3,-1
	char *argv2[MAXARG];
	char argument[MAXARG][MAXARGLENGTH];

	for(i = 0; i < argc2; ++i){
  46:	07605063          	blez	s6,a6 <main+0xa6>
  4a:	008a0493          	addi	s1,s4,8
  4e:	797d                	lui	s2,0xfffff
  50:	4b090793          	addi	a5,s2,1200 # fffffffffffff4b0 <base+0xffffffffffffe4a0>
  54:	00878933          	add	s2,a5,s0
  58:	00098a9b          	sext.w	s5,s3
  5c:	39f9                	addiw	s3,s3,-2
  5e:	02099793          	slli	a5,s3,0x20
  62:	01d7d993          	srli	s3,a5,0x1d
  66:	0a41                	addi	s4,s4,16
  68:	99d2                	add	s3,s3,s4
		strcpy(argument[i], argv[i + 1]);
  6a:	608c                	ld	a1,0(s1)
  6c:	854a                	mv	a0,s2
  6e:	108000ef          	jal	176 <strcpy>
	for(i = 0; i < argc2; ++i){
  72:	04a1                	addi	s1,s1,8
  74:	04090913          	addi	s2,s2,64
  78:	ff3499e3          	bne	s1,s3,6a <main+0x6a>
  7c:	fffa871b          	addiw	a4,s5,-1
	}

	for(int k = 0; buf[k] != 0; ++k){ // 逐个处理字符
  80:	db044783          	lbu	a5,-592(s0)
  84:	cfe9                	beqz	a5,15e <main+0x15e>
  86:	db140493          	addi	s1,s0,-591
	int j = 0; // 第i个参数的第j个字母
  8a:	4681                	li	a3,0
		if(buf[k] == '\n'){
  8c:	49a9                	li	s3,10
			if(fork() == 0){
				exec(argv2[0], argv2);
				fprintf(2, "exec error\n");
			}
			wait((int*)0);
		} else if (buf[k] == ' ') {
  8e:	02000a13          	li	s4,32
			argument[i++][++j] = 0;
			j = 0;
		} else {
			argument[i][j++] = buf[k];
  92:	797d                	lui	s2,0xfffff
  94:	fb090613          	addi	a2,s2,-80 # ffffffffffffefb0 <base+0xffffffffffffdfa0>
  98:	00860933          	add	s2,a2,s0
			j = 0;
  9c:	4a81                	li	s5,0
  9e:	7bfd                	lui	s7,0xfffff
  a0:	500b8b93          	addi	s7,s7,1280 # fffffffffffff500 <base+0xffffffffffffe4f0>
  a4:	a04d                	j	146 <main+0x146>
	for(i = 0; i < argc2; ++i){
  a6:	4701                	li	a4,0
  a8:	bfe1                	j	80 <main+0x80>
			argument[i++][++j] = 0;
  aa:	0017061b          	addiw	a2,a4,1
  ae:	2685                	addiw	a3,a3,1
  b0:	00671793          	slli	a5,a4,0x6
  b4:	97ca                	add	a5,a5,s2
  b6:	97b6                	add	a5,a5,a3
  b8:	50078023          	sb	zero,1280(a5)
			argument[i][0] = 0;
  bc:	00661793          	slli	a5,a2,0x6
  c0:	97ca                	add	a5,a5,s2
  c2:	50078023          	sb	zero,1280(a5)
			for(int t = 0; t < i; ++t){
  c6:	02c05563          	blez	a2,f0 <main+0xf0>
  ca:	fb0b8793          	addi	a5,s7,-80
  ce:	008786b3          	add	a3,a5,s0
  d2:	cb040793          	addi	a5,s0,-848
  d6:	02071593          	slli	a1,a4,0x20
  da:	01d5d713          	srli	a4,a1,0x1d
  de:	cb840593          	addi	a1,s0,-840
  e2:	972e                	add	a4,a4,a1
				argv2[t] = argument[t];
  e4:	e394                	sd	a3,0(a5)
			for(int t = 0; t < i; ++t){
  e6:	04068693          	addi	a3,a3,64
  ea:	07a1                	addi	a5,a5,8
  ec:	fee79ce3          	bne	a5,a4,e4 <main+0xe4>
			argv2[i] = 0;
  f0:	060e                	slli	a2,a2,0x3
  f2:	fb060793          	addi	a5,a2,-80
  f6:	00878633          	add	a2,a5,s0
  fa:	d0063023          	sd	zero,-768(a2)
			if(fork() == 0){
  fe:	2c8000ef          	jal	3c6 <fork>
 102:	c519                	beqz	a0,110 <main+0x110>
			wait((int*)0);
 104:	8556                	mv	a0,s5
 106:	2d0000ef          	jal	3d6 <wait>
			i = argc2;
 10a:	875a                	mv	a4,s6
			j = 0;
 10c:	86d6                	mv	a3,s5
 10e:	a805                	j	13e <main+0x13e>
				exec(argv2[0], argv2);
 110:	cb040593          	addi	a1,s0,-848
 114:	cb043503          	ld	a0,-848(s0)
 118:	2ee000ef          	jal	406 <exec>
				fprintf(2, "exec error\n");
 11c:	00001597          	auipc	a1,0x1
 120:	88458593          	addi	a1,a1,-1916 # 9a0 <malloc+0x106>
 124:	4509                	li	a0,2
 126:	696000ef          	jal	7bc <fprintf>
 12a:	bfe9                	j	104 <main+0x104>
			argument[i++][++j] = 0;
 12c:	2685                	addiw	a3,a3,1
 12e:	00671793          	slli	a5,a4,0x6
 132:	97ca                	add	a5,a5,s2
 134:	97b6                	add	a5,a5,a3
 136:	50078023          	sb	zero,1280(a5)
 13a:	2705                	addiw	a4,a4,1
			j = 0;
 13c:	86d6                	mv	a3,s5
	for(int k = 0; buf[k] != 0; ++k){ // 逐个处理字符
 13e:	0485                	addi	s1,s1,1
 140:	fff4c783          	lbu	a5,-1(s1)
 144:	cf89                	beqz	a5,15e <main+0x15e>
		if(buf[k] == '\n'){
 146:	f73782e3          	beq	a5,s3,aa <main+0xaa>
		} else if (buf[k] == ' ') {
 14a:	ff4781e3          	beq	a5,s4,12c <main+0x12c>
			argument[i][j++] = buf[k];
 14e:	00671613          	slli	a2,a4,0x6
 152:	964a                	add	a2,a2,s2
 154:	9636                	add	a2,a2,a3
 156:	50f60023          	sb	a5,1280(a2)
 15a:	2685                	addiw	a3,a3,1
 15c:	b7cd                	j	13e <main+0x13e>
		}
	}

  exit(0);
 15e:	4501                	li	a0,0
 160:	26e000ef          	jal	3ce <exit>

0000000000000164 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 164:	1141                	addi	sp,sp,-16
 166:	e406                	sd	ra,8(sp)
 168:	e022                	sd	s0,0(sp)
 16a:	0800                	addi	s0,sp,16
  extern int main();
  main();
 16c:	e95ff0ef          	jal	0 <main>
  exit(0);
 170:	4501                	li	a0,0
 172:	25c000ef          	jal	3ce <exit>

0000000000000176 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 176:	1141                	addi	sp,sp,-16
 178:	e422                	sd	s0,8(sp)
 17a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 17c:	87aa                	mv	a5,a0
 17e:	0585                	addi	a1,a1,1
 180:	0785                	addi	a5,a5,1
 182:	fff5c703          	lbu	a4,-1(a1)
 186:	fee78fa3          	sb	a4,-1(a5)
 18a:	fb75                	bnez	a4,17e <strcpy+0x8>
    ;
  return os;
}
 18c:	6422                	ld	s0,8(sp)
 18e:	0141                	addi	sp,sp,16
 190:	8082                	ret

0000000000000192 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 192:	1141                	addi	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 198:	00054783          	lbu	a5,0(a0)
 19c:	cb91                	beqz	a5,1b0 <strcmp+0x1e>
 19e:	0005c703          	lbu	a4,0(a1)
 1a2:	00f71763          	bne	a4,a5,1b0 <strcmp+0x1e>
    p++, q++;
 1a6:	0505                	addi	a0,a0,1
 1a8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1aa:	00054783          	lbu	a5,0(a0)
 1ae:	fbe5                	bnez	a5,19e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1b0:	0005c503          	lbu	a0,0(a1)
}
 1b4:	40a7853b          	subw	a0,a5,a0
 1b8:	6422                	ld	s0,8(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strlen>:

uint
strlen(const char *s)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e422                	sd	s0,8(sp)
 1c2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1c4:	00054783          	lbu	a5,0(a0)
 1c8:	cf91                	beqz	a5,1e4 <strlen+0x26>
 1ca:	0505                	addi	a0,a0,1
 1cc:	87aa                	mv	a5,a0
 1ce:	86be                	mv	a3,a5
 1d0:	0785                	addi	a5,a5,1
 1d2:	fff7c703          	lbu	a4,-1(a5)
 1d6:	ff65                	bnez	a4,1ce <strlen+0x10>
 1d8:	40a6853b          	subw	a0,a3,a0
 1dc:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret
  for(n = 0; s[n]; n++)
 1e4:	4501                	li	a0,0
 1e6:	bfe5                	j	1de <strlen+0x20>

00000000000001e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e8:	1141                	addi	sp,sp,-16
 1ea:	e422                	sd	s0,8(sp)
 1ec:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1ee:	ca19                	beqz	a2,204 <memset+0x1c>
 1f0:	87aa                	mv	a5,a0
 1f2:	1602                	slli	a2,a2,0x20
 1f4:	9201                	srli	a2,a2,0x20
 1f6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1fa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1fe:	0785                	addi	a5,a5,1
 200:	fee79de3          	bne	a5,a4,1fa <memset+0x12>
  }
  return dst;
}
 204:	6422                	ld	s0,8(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret

000000000000020a <strchr>:

char*
strchr(const char *s, char c)
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 210:	00054783          	lbu	a5,0(a0)
 214:	cb99                	beqz	a5,22a <strchr+0x20>
    if(*s == c)
 216:	00f58763          	beq	a1,a5,224 <strchr+0x1a>
  for(; *s; s++)
 21a:	0505                	addi	a0,a0,1
 21c:	00054783          	lbu	a5,0(a0)
 220:	fbfd                	bnez	a5,216 <strchr+0xc>
      return (char*)s;
  return 0;
 222:	4501                	li	a0,0
}
 224:	6422                	ld	s0,8(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
  return 0;
 22a:	4501                	li	a0,0
 22c:	bfe5                	j	224 <strchr+0x1a>

000000000000022e <gets>:

char*
gets(char *buf, int max)
{
 22e:	711d                	addi	sp,sp,-96
 230:	ec86                	sd	ra,88(sp)
 232:	e8a2                	sd	s0,80(sp)
 234:	e4a6                	sd	s1,72(sp)
 236:	e0ca                	sd	s2,64(sp)
 238:	fc4e                	sd	s3,56(sp)
 23a:	f852                	sd	s4,48(sp)
 23c:	f456                	sd	s5,40(sp)
 23e:	f05a                	sd	s6,32(sp)
 240:	ec5e                	sd	s7,24(sp)
 242:	1080                	addi	s0,sp,96
 244:	8baa                	mv	s7,a0
 246:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 248:	892a                	mv	s2,a0
 24a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 24c:	4aa9                	li	s5,10
 24e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 250:	89a6                	mv	s3,s1
 252:	2485                	addiw	s1,s1,1
 254:	0344d663          	bge	s1,s4,280 <gets+0x52>
    cc = read(0, &c, 1);
 258:	4605                	li	a2,1
 25a:	faf40593          	addi	a1,s0,-81
 25e:	4501                	li	a0,0
 260:	186000ef          	jal	3e6 <read>
    if(cc < 1)
 264:	00a05e63          	blez	a0,280 <gets+0x52>
    buf[i++] = c;
 268:	faf44783          	lbu	a5,-81(s0)
 26c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 270:	01578763          	beq	a5,s5,27e <gets+0x50>
 274:	0905                	addi	s2,s2,1
 276:	fd679de3          	bne	a5,s6,250 <gets+0x22>
    buf[i++] = c;
 27a:	89a6                	mv	s3,s1
 27c:	a011                	j	280 <gets+0x52>
 27e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 280:	99de                	add	s3,s3,s7
 282:	00098023          	sb	zero,0(s3)
  return buf;
}
 286:	855e                	mv	a0,s7
 288:	60e6                	ld	ra,88(sp)
 28a:	6446                	ld	s0,80(sp)
 28c:	64a6                	ld	s1,72(sp)
 28e:	6906                	ld	s2,64(sp)
 290:	79e2                	ld	s3,56(sp)
 292:	7a42                	ld	s4,48(sp)
 294:	7aa2                	ld	s5,40(sp)
 296:	7b02                	ld	s6,32(sp)
 298:	6be2                	ld	s7,24(sp)
 29a:	6125                	addi	sp,sp,96
 29c:	8082                	ret

000000000000029e <stat>:

int
stat(const char *n, struct stat *st)
{
 29e:	1101                	addi	sp,sp,-32
 2a0:	ec06                	sd	ra,24(sp)
 2a2:	e822                	sd	s0,16(sp)
 2a4:	e04a                	sd	s2,0(sp)
 2a6:	1000                	addi	s0,sp,32
 2a8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2aa:	4581                	li	a1,0
 2ac:	162000ef          	jal	40e <open>
  if(fd < 0)
 2b0:	02054263          	bltz	a0,2d4 <stat+0x36>
 2b4:	e426                	sd	s1,8(sp)
 2b6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2b8:	85ca                	mv	a1,s2
 2ba:	16c000ef          	jal	426 <fstat>
 2be:	892a                	mv	s2,a0
  close(fd);
 2c0:	8526                	mv	a0,s1
 2c2:	134000ef          	jal	3f6 <close>
  return r;
 2c6:	64a2                	ld	s1,8(sp)
}
 2c8:	854a                	mv	a0,s2
 2ca:	60e2                	ld	ra,24(sp)
 2cc:	6442                	ld	s0,16(sp)
 2ce:	6902                	ld	s2,0(sp)
 2d0:	6105                	addi	sp,sp,32
 2d2:	8082                	ret
    return -1;
 2d4:	597d                	li	s2,-1
 2d6:	bfcd                	j	2c8 <stat+0x2a>

00000000000002d8 <atoi>:

int
atoi(const char *s)
{
 2d8:	1141                	addi	sp,sp,-16
 2da:	e422                	sd	s0,8(sp)
 2dc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2de:	00054683          	lbu	a3,0(a0)
 2e2:	fd06879b          	addiw	a5,a3,-48
 2e6:	0ff7f793          	zext.b	a5,a5
 2ea:	4625                	li	a2,9
 2ec:	02f66863          	bltu	a2,a5,31c <atoi+0x44>
 2f0:	872a                	mv	a4,a0
  n = 0;
 2f2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2f4:	0705                	addi	a4,a4,1
 2f6:	0025179b          	slliw	a5,a0,0x2
 2fa:	9fa9                	addw	a5,a5,a0
 2fc:	0017979b          	slliw	a5,a5,0x1
 300:	9fb5                	addw	a5,a5,a3
 302:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 306:	00074683          	lbu	a3,0(a4)
 30a:	fd06879b          	addiw	a5,a3,-48
 30e:	0ff7f793          	zext.b	a5,a5
 312:	fef671e3          	bgeu	a2,a5,2f4 <atoi+0x1c>
  return n;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
  n = 0;
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <atoi+0x3e>

0000000000000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 326:	02b57463          	bgeu	a0,a1,34e <memmove+0x2e>
    while(n-- > 0)
 32a:	00c05f63          	blez	a2,348 <memmove+0x28>
 32e:	1602                	slli	a2,a2,0x20
 330:	9201                	srli	a2,a2,0x20
 332:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 336:	872a                	mv	a4,a0
      *dst++ = *src++;
 338:	0585                	addi	a1,a1,1
 33a:	0705                	addi	a4,a4,1
 33c:	fff5c683          	lbu	a3,-1(a1)
 340:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 344:	fef71ae3          	bne	a4,a5,338 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 348:	6422                	ld	s0,8(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret
    dst += n;
 34e:	00c50733          	add	a4,a0,a2
    src += n;
 352:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 354:	fec05ae3          	blez	a2,348 <memmove+0x28>
 358:	fff6079b          	addiw	a5,a2,-1
 35c:	1782                	slli	a5,a5,0x20
 35e:	9381                	srli	a5,a5,0x20
 360:	fff7c793          	not	a5,a5
 364:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 366:	15fd                	addi	a1,a1,-1
 368:	177d                	addi	a4,a4,-1
 36a:	0005c683          	lbu	a3,0(a1)
 36e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 372:	fee79ae3          	bne	a5,a4,366 <memmove+0x46>
 376:	bfc9                	j	348 <memmove+0x28>

0000000000000378 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e422                	sd	s0,8(sp)
 37c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 37e:	ca05                	beqz	a2,3ae <memcmp+0x36>
 380:	fff6069b          	addiw	a3,a2,-1
 384:	1682                	slli	a3,a3,0x20
 386:	9281                	srli	a3,a3,0x20
 388:	0685                	addi	a3,a3,1
 38a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 38c:	00054783          	lbu	a5,0(a0)
 390:	0005c703          	lbu	a4,0(a1)
 394:	00e79863          	bne	a5,a4,3a4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 398:	0505                	addi	a0,a0,1
    p2++;
 39a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 39c:	fed518e3          	bne	a0,a3,38c <memcmp+0x14>
  }
  return 0;
 3a0:	4501                	li	a0,0
 3a2:	a019                	j	3a8 <memcmp+0x30>
      return *p1 - *p2;
 3a4:	40e7853b          	subw	a0,a5,a4
}
 3a8:	6422                	ld	s0,8(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret
  return 0;
 3ae:	4501                	li	a0,0
 3b0:	bfe5                	j	3a8 <memcmp+0x30>

00000000000003b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3b2:	1141                	addi	sp,sp,-16
 3b4:	e406                	sd	ra,8(sp)
 3b6:	e022                	sd	s0,0(sp)
 3b8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3ba:	f67ff0ef          	jal	320 <memmove>
}
 3be:	60a2                	ld	ra,8(sp)
 3c0:	6402                	ld	s0,0(sp)
 3c2:	0141                	addi	sp,sp,16
 3c4:	8082                	ret

00000000000003c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3c6:	4885                	li	a7,1
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ce:	4889                	li	a7,2
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3d6:	488d                	li	a7,3
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3de:	4891                	li	a7,4
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <read>:
.global read
read:
 li a7, SYS_read
 3e6:	4895                	li	a7,5
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <write>:
.global write
write:
 li a7, SYS_write
 3ee:	48c1                	li	a7,16
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <close>:
.global close
close:
 li a7, SYS_close
 3f6:	48d5                	li	a7,21
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 3fe:	4899                	li	a7,6
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <exec>:
.global exec
exec:
 li a7, SYS_exec
 406:	489d                	li	a7,7
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <open>:
.global open
open:
 li a7, SYS_open
 40e:	48bd                	li	a7,15
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 416:	48c5                	li	a7,17
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 41e:	48c9                	li	a7,18
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 426:	48a1                	li	a7,8
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <link>:
.global link
link:
 li a7, SYS_link
 42e:	48cd                	li	a7,19
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 436:	48d1                	li	a7,20
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 43e:	48a5                	li	a7,9
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <dup>:
.global dup
dup:
 li a7, SYS_dup
 446:	48a9                	li	a7,10
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 44e:	48ad                	li	a7,11
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 456:	48b1                	li	a7,12
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 45e:	48b5                	li	a7,13
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 466:	48b9                	li	a7,14
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 46e:	1101                	addi	sp,sp,-32
 470:	ec06                	sd	ra,24(sp)
 472:	e822                	sd	s0,16(sp)
 474:	1000                	addi	s0,sp,32
 476:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 47a:	4605                	li	a2,1
 47c:	fef40593          	addi	a1,s0,-17
 480:	f6fff0ef          	jal	3ee <write>
}
 484:	60e2                	ld	ra,24(sp)
 486:	6442                	ld	s0,16(sp)
 488:	6105                	addi	sp,sp,32
 48a:	8082                	ret

000000000000048c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 48c:	7139                	addi	sp,sp,-64
 48e:	fc06                	sd	ra,56(sp)
 490:	f822                	sd	s0,48(sp)
 492:	f426                	sd	s1,40(sp)
 494:	0080                	addi	s0,sp,64
 496:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 498:	c299                	beqz	a3,49e <printint+0x12>
 49a:	0805c963          	bltz	a1,52c <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 49e:	2581                	sext.w	a1,a1
  neg = 0;
 4a0:	4881                	li	a7,0
 4a2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4a6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4a8:	2601                	sext.w	a2,a2
 4aa:	00000517          	auipc	a0,0x0
 4ae:	50e50513          	addi	a0,a0,1294 # 9b8 <digits>
 4b2:	883a                	mv	a6,a4
 4b4:	2705                	addiw	a4,a4,1
 4b6:	02c5f7bb          	remuw	a5,a1,a2
 4ba:	1782                	slli	a5,a5,0x20
 4bc:	9381                	srli	a5,a5,0x20
 4be:	97aa                	add	a5,a5,a0
 4c0:	0007c783          	lbu	a5,0(a5)
 4c4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4c8:	0005879b          	sext.w	a5,a1
 4cc:	02c5d5bb          	divuw	a1,a1,a2
 4d0:	0685                	addi	a3,a3,1
 4d2:	fec7f0e3          	bgeu	a5,a2,4b2 <printint+0x26>
  if(neg)
 4d6:	00088c63          	beqz	a7,4ee <printint+0x62>
    buf[i++] = '-';
 4da:	fd070793          	addi	a5,a4,-48
 4de:	00878733          	add	a4,a5,s0
 4e2:	02d00793          	li	a5,45
 4e6:	fef70823          	sb	a5,-16(a4)
 4ea:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4ee:	02e05a63          	blez	a4,522 <printint+0x96>
 4f2:	f04a                	sd	s2,32(sp)
 4f4:	ec4e                	sd	s3,24(sp)
 4f6:	fc040793          	addi	a5,s0,-64
 4fa:	00e78933          	add	s2,a5,a4
 4fe:	fff78993          	addi	s3,a5,-1
 502:	99ba                	add	s3,s3,a4
 504:	377d                	addiw	a4,a4,-1
 506:	1702                	slli	a4,a4,0x20
 508:	9301                	srli	a4,a4,0x20
 50a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 50e:	fff94583          	lbu	a1,-1(s2)
 512:	8526                	mv	a0,s1
 514:	f5bff0ef          	jal	46e <putc>
  while(--i >= 0)
 518:	197d                	addi	s2,s2,-1
 51a:	ff391ae3          	bne	s2,s3,50e <printint+0x82>
 51e:	7902                	ld	s2,32(sp)
 520:	69e2                	ld	s3,24(sp)
}
 522:	70e2                	ld	ra,56(sp)
 524:	7442                	ld	s0,48(sp)
 526:	74a2                	ld	s1,40(sp)
 528:	6121                	addi	sp,sp,64
 52a:	8082                	ret
    x = -xx;
 52c:	40b005bb          	negw	a1,a1
    neg = 1;
 530:	4885                	li	a7,1
    x = -xx;
 532:	bf85                	j	4a2 <printint+0x16>

0000000000000534 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 534:	711d                	addi	sp,sp,-96
 536:	ec86                	sd	ra,88(sp)
 538:	e8a2                	sd	s0,80(sp)
 53a:	e0ca                	sd	s2,64(sp)
 53c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 53e:	0005c903          	lbu	s2,0(a1)
 542:	26090863          	beqz	s2,7b2 <vprintf+0x27e>
 546:	e4a6                	sd	s1,72(sp)
 548:	fc4e                	sd	s3,56(sp)
 54a:	f852                	sd	s4,48(sp)
 54c:	f456                	sd	s5,40(sp)
 54e:	f05a                	sd	s6,32(sp)
 550:	ec5e                	sd	s7,24(sp)
 552:	e862                	sd	s8,16(sp)
 554:	e466                	sd	s9,8(sp)
 556:	8b2a                	mv	s6,a0
 558:	8a2e                	mv	s4,a1
 55a:	8bb2                	mv	s7,a2
  state = 0;
 55c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 55e:	4481                	li	s1,0
 560:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 562:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 566:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 56a:	06c00c93          	li	s9,108
 56e:	a005                	j	58e <vprintf+0x5a>
        putc(fd, c0);
 570:	85ca                	mv	a1,s2
 572:	855a                	mv	a0,s6
 574:	efbff0ef          	jal	46e <putc>
 578:	a019                	j	57e <vprintf+0x4a>
    } else if(state == '%'){
 57a:	03598263          	beq	s3,s5,59e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 57e:	2485                	addiw	s1,s1,1
 580:	8726                	mv	a4,s1
 582:	009a07b3          	add	a5,s4,s1
 586:	0007c903          	lbu	s2,0(a5)
 58a:	20090c63          	beqz	s2,7a2 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 58e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 592:	fe0994e3          	bnez	s3,57a <vprintf+0x46>
      if(c0 == '%'){
 596:	fd579de3          	bne	a5,s5,570 <vprintf+0x3c>
        state = '%';
 59a:	89be                	mv	s3,a5
 59c:	b7cd                	j	57e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 59e:	00ea06b3          	add	a3,s4,a4
 5a2:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5a6:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5a8:	c681                	beqz	a3,5b0 <vprintf+0x7c>
 5aa:	9752                	add	a4,a4,s4
 5ac:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5b0:	03878f63          	beq	a5,s8,5ee <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 5b4:	05978963          	beq	a5,s9,606 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5b8:	07500713          	li	a4,117
 5bc:	0ee78363          	beq	a5,a4,6a2 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5c0:	07800713          	li	a4,120
 5c4:	12e78563          	beq	a5,a4,6ee <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5c8:	07000713          	li	a4,112
 5cc:	14e78a63          	beq	a5,a4,720 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 5d0:	07300713          	li	a4,115
 5d4:	18e78a63          	beq	a5,a4,768 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5d8:	02500713          	li	a4,37
 5dc:	04e79563          	bne	a5,a4,626 <vprintf+0xf2>
        putc(fd, '%');
 5e0:	02500593          	li	a1,37
 5e4:	855a                	mv	a0,s6
 5e6:	e89ff0ef          	jal	46e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	bf49                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5ee:	008b8913          	addi	s2,s7,8
 5f2:	4685                	li	a3,1
 5f4:	4629                	li	a2,10
 5f6:	000ba583          	lw	a1,0(s7)
 5fa:	855a                	mv	a0,s6
 5fc:	e91ff0ef          	jal	48c <printint>
 600:	8bca                	mv	s7,s2
      state = 0;
 602:	4981                	li	s3,0
 604:	bfad                	j	57e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 606:	06400793          	li	a5,100
 60a:	02f68963          	beq	a3,a5,63c <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 60e:	06c00793          	li	a5,108
 612:	04f68263          	beq	a3,a5,656 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 616:	07500793          	li	a5,117
 61a:	0af68063          	beq	a3,a5,6ba <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 61e:	07800793          	li	a5,120
 622:	0ef68263          	beq	a3,a5,706 <vprintf+0x1d2>
        putc(fd, '%');
 626:	02500593          	li	a1,37
 62a:	855a                	mv	a0,s6
 62c:	e43ff0ef          	jal	46e <putc>
        putc(fd, c0);
 630:	85ca                	mv	a1,s2
 632:	855a                	mv	a0,s6
 634:	e3bff0ef          	jal	46e <putc>
      state = 0;
 638:	4981                	li	s3,0
 63a:	b791                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 63c:	008b8913          	addi	s2,s7,8
 640:	4685                	li	a3,1
 642:	4629                	li	a2,10
 644:	000ba583          	lw	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	e43ff0ef          	jal	48c <printint>
        i += 1;
 64e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 650:	8bca                	mv	s7,s2
      state = 0;
 652:	4981                	li	s3,0
        i += 1;
 654:	b72d                	j	57e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 656:	06400793          	li	a5,100
 65a:	02f60763          	beq	a2,a5,688 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 65e:	07500793          	li	a5,117
 662:	06f60963          	beq	a2,a5,6d4 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 666:	07800793          	li	a5,120
 66a:	faf61ee3          	bne	a2,a5,626 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 66e:	008b8913          	addi	s2,s7,8
 672:	4681                	li	a3,0
 674:	4641                	li	a2,16
 676:	000ba583          	lw	a1,0(s7)
 67a:	855a                	mv	a0,s6
 67c:	e11ff0ef          	jal	48c <printint>
        i += 2;
 680:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 682:	8bca                	mv	s7,s2
      state = 0;
 684:	4981                	li	s3,0
        i += 2;
 686:	bde5                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 688:	008b8913          	addi	s2,s7,8
 68c:	4685                	li	a3,1
 68e:	4629                	li	a2,10
 690:	000ba583          	lw	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	df7ff0ef          	jal	48c <printint>
        i += 2;
 69a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 69c:	8bca                	mv	s7,s2
      state = 0;
 69e:	4981                	li	s3,0
        i += 2;
 6a0:	bdf9                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 6a2:	008b8913          	addi	s2,s7,8
 6a6:	4681                	li	a3,0
 6a8:	4629                	li	a2,10
 6aa:	000ba583          	lw	a1,0(s7)
 6ae:	855a                	mv	a0,s6
 6b0:	dddff0ef          	jal	48c <printint>
 6b4:	8bca                	mv	s7,s2
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b5d9                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ba:	008b8913          	addi	s2,s7,8
 6be:	4681                	li	a3,0
 6c0:	4629                	li	a2,10
 6c2:	000ba583          	lw	a1,0(s7)
 6c6:	855a                	mv	a0,s6
 6c8:	dc5ff0ef          	jal	48c <printint>
        i += 1;
 6cc:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ce:	8bca                	mv	s7,s2
      state = 0;
 6d0:	4981                	li	s3,0
        i += 1;
 6d2:	b575                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d4:	008b8913          	addi	s2,s7,8
 6d8:	4681                	li	a3,0
 6da:	4629                	li	a2,10
 6dc:	000ba583          	lw	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	dabff0ef          	jal	48c <printint>
        i += 2;
 6e6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e8:	8bca                	mv	s7,s2
      state = 0;
 6ea:	4981                	li	s3,0
        i += 2;
 6ec:	bd49                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 6ee:	008b8913          	addi	s2,s7,8
 6f2:	4681                	li	a3,0
 6f4:	4641                	li	a2,16
 6f6:	000ba583          	lw	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	d91ff0ef          	jal	48c <printint>
 700:	8bca                	mv	s7,s2
      state = 0;
 702:	4981                	li	s3,0
 704:	bdad                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 706:	008b8913          	addi	s2,s7,8
 70a:	4681                	li	a3,0
 70c:	4641                	li	a2,16
 70e:	000ba583          	lw	a1,0(s7)
 712:	855a                	mv	a0,s6
 714:	d79ff0ef          	jal	48c <printint>
        i += 1;
 718:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 71a:	8bca                	mv	s7,s2
      state = 0;
 71c:	4981                	li	s3,0
        i += 1;
 71e:	b585                	j	57e <vprintf+0x4a>
 720:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 722:	008b8d13          	addi	s10,s7,8
 726:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 72a:	03000593          	li	a1,48
 72e:	855a                	mv	a0,s6
 730:	d3fff0ef          	jal	46e <putc>
  putc(fd, 'x');
 734:	07800593          	li	a1,120
 738:	855a                	mv	a0,s6
 73a:	d35ff0ef          	jal	46e <putc>
 73e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 740:	00000b97          	auipc	s7,0x0
 744:	278b8b93          	addi	s7,s7,632 # 9b8 <digits>
 748:	03c9d793          	srli	a5,s3,0x3c
 74c:	97de                	add	a5,a5,s7
 74e:	0007c583          	lbu	a1,0(a5)
 752:	855a                	mv	a0,s6
 754:	d1bff0ef          	jal	46e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 758:	0992                	slli	s3,s3,0x4
 75a:	397d                	addiw	s2,s2,-1
 75c:	fe0916e3          	bnez	s2,748 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 760:	8bea                	mv	s7,s10
      state = 0;
 762:	4981                	li	s3,0
 764:	6d02                	ld	s10,0(sp)
 766:	bd21                	j	57e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 768:	008b8993          	addi	s3,s7,8
 76c:	000bb903          	ld	s2,0(s7)
 770:	00090f63          	beqz	s2,78e <vprintf+0x25a>
        for(; *s; s++)
 774:	00094583          	lbu	a1,0(s2)
 778:	c195                	beqz	a1,79c <vprintf+0x268>
          putc(fd, *s);
 77a:	855a                	mv	a0,s6
 77c:	cf3ff0ef          	jal	46e <putc>
        for(; *s; s++)
 780:	0905                	addi	s2,s2,1
 782:	00094583          	lbu	a1,0(s2)
 786:	f9f5                	bnez	a1,77a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 788:	8bce                	mv	s7,s3
      state = 0;
 78a:	4981                	li	s3,0
 78c:	bbcd                	j	57e <vprintf+0x4a>
          s = "(null)";
 78e:	00000917          	auipc	s2,0x0
 792:	22290913          	addi	s2,s2,546 # 9b0 <malloc+0x116>
        for(; *s; s++)
 796:	02800593          	li	a1,40
 79a:	b7c5                	j	77a <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 79c:	8bce                	mv	s7,s3
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	bbf9                	j	57e <vprintf+0x4a>
 7a2:	64a6                	ld	s1,72(sp)
 7a4:	79e2                	ld	s3,56(sp)
 7a6:	7a42                	ld	s4,48(sp)
 7a8:	7aa2                	ld	s5,40(sp)
 7aa:	7b02                	ld	s6,32(sp)
 7ac:	6be2                	ld	s7,24(sp)
 7ae:	6c42                	ld	s8,16(sp)
 7b0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7b2:	60e6                	ld	ra,88(sp)
 7b4:	6446                	ld	s0,80(sp)
 7b6:	6906                	ld	s2,64(sp)
 7b8:	6125                	addi	sp,sp,96
 7ba:	8082                	ret

00000000000007bc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7bc:	715d                	addi	sp,sp,-80
 7be:	ec06                	sd	ra,24(sp)
 7c0:	e822                	sd	s0,16(sp)
 7c2:	1000                	addi	s0,sp,32
 7c4:	e010                	sd	a2,0(s0)
 7c6:	e414                	sd	a3,8(s0)
 7c8:	e818                	sd	a4,16(s0)
 7ca:	ec1c                	sd	a5,24(s0)
 7cc:	03043023          	sd	a6,32(s0)
 7d0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d8:	8622                	mv	a2,s0
 7da:	d5bff0ef          	jal	534 <vprintf>
}
 7de:	60e2                	ld	ra,24(sp)
 7e0:	6442                	ld	s0,16(sp)
 7e2:	6161                	addi	sp,sp,80
 7e4:	8082                	ret

00000000000007e6 <printf>:

void
printf(const char *fmt, ...)
{
 7e6:	711d                	addi	sp,sp,-96
 7e8:	ec06                	sd	ra,24(sp)
 7ea:	e822                	sd	s0,16(sp)
 7ec:	1000                	addi	s0,sp,32
 7ee:	e40c                	sd	a1,8(s0)
 7f0:	e810                	sd	a2,16(s0)
 7f2:	ec14                	sd	a3,24(s0)
 7f4:	f018                	sd	a4,32(s0)
 7f6:	f41c                	sd	a5,40(s0)
 7f8:	03043823          	sd	a6,48(s0)
 7fc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 800:	00840613          	addi	a2,s0,8
 804:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 808:	85aa                	mv	a1,a0
 80a:	4505                	li	a0,1
 80c:	d29ff0ef          	jal	534 <vprintf>
}
 810:	60e2                	ld	ra,24(sp)
 812:	6442                	ld	s0,16(sp)
 814:	6125                	addi	sp,sp,96
 816:	8082                	ret

0000000000000818 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 818:	1141                	addi	sp,sp,-16
 81a:	e422                	sd	s0,8(sp)
 81c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 81e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 822:	00000797          	auipc	a5,0x0
 826:	7de7b783          	ld	a5,2014(a5) # 1000 <freep>
 82a:	a02d                	j	854 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 82c:	4618                	lw	a4,8(a2)
 82e:	9f2d                	addw	a4,a4,a1
 830:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 834:	6398                	ld	a4,0(a5)
 836:	6310                	ld	a2,0(a4)
 838:	a83d                	j	876 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 83a:	ff852703          	lw	a4,-8(a0)
 83e:	9f31                	addw	a4,a4,a2
 840:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 842:	ff053683          	ld	a3,-16(a0)
 846:	a091                	j	88a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 848:	6398                	ld	a4,0(a5)
 84a:	00e7e463          	bltu	a5,a4,852 <free+0x3a>
 84e:	00e6ea63          	bltu	a3,a4,862 <free+0x4a>
{
 852:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 854:	fed7fae3          	bgeu	a5,a3,848 <free+0x30>
 858:	6398                	ld	a4,0(a5)
 85a:	00e6e463          	bltu	a3,a4,862 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85e:	fee7eae3          	bltu	a5,a4,852 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 862:	ff852583          	lw	a1,-8(a0)
 866:	6390                	ld	a2,0(a5)
 868:	02059813          	slli	a6,a1,0x20
 86c:	01c85713          	srli	a4,a6,0x1c
 870:	9736                	add	a4,a4,a3
 872:	fae60de3          	beq	a2,a4,82c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 876:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 87a:	4790                	lw	a2,8(a5)
 87c:	02061593          	slli	a1,a2,0x20
 880:	01c5d713          	srli	a4,a1,0x1c
 884:	973e                	add	a4,a4,a5
 886:	fae68ae3          	beq	a3,a4,83a <free+0x22>
    p->s.ptr = bp->s.ptr;
 88a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 88c:	00000717          	auipc	a4,0x0
 890:	76f73a23          	sd	a5,1908(a4) # 1000 <freep>
}
 894:	6422                	ld	s0,8(sp)
 896:	0141                	addi	sp,sp,16
 898:	8082                	ret

000000000000089a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 89a:	7139                	addi	sp,sp,-64
 89c:	fc06                	sd	ra,56(sp)
 89e:	f822                	sd	s0,48(sp)
 8a0:	f426                	sd	s1,40(sp)
 8a2:	ec4e                	sd	s3,24(sp)
 8a4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a6:	02051493          	slli	s1,a0,0x20
 8aa:	9081                	srli	s1,s1,0x20
 8ac:	04bd                	addi	s1,s1,15
 8ae:	8091                	srli	s1,s1,0x4
 8b0:	0014899b          	addiw	s3,s1,1
 8b4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8b6:	00000517          	auipc	a0,0x0
 8ba:	74a53503          	ld	a0,1866(a0) # 1000 <freep>
 8be:	c915                	beqz	a0,8f2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c2:	4798                	lw	a4,8(a5)
 8c4:	08977a63          	bgeu	a4,s1,958 <malloc+0xbe>
 8c8:	f04a                	sd	s2,32(sp)
 8ca:	e852                	sd	s4,16(sp)
 8cc:	e456                	sd	s5,8(sp)
 8ce:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8d0:	8a4e                	mv	s4,s3
 8d2:	0009871b          	sext.w	a4,s3
 8d6:	6685                	lui	a3,0x1
 8d8:	00d77363          	bgeu	a4,a3,8de <malloc+0x44>
 8dc:	6a05                	lui	s4,0x1
 8de:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8e2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e6:	00000917          	auipc	s2,0x0
 8ea:	71a90913          	addi	s2,s2,1818 # 1000 <freep>
  if(p == (char*)-1)
 8ee:	5afd                	li	s5,-1
 8f0:	a081                	j	930 <malloc+0x96>
 8f2:	f04a                	sd	s2,32(sp)
 8f4:	e852                	sd	s4,16(sp)
 8f6:	e456                	sd	s5,8(sp)
 8f8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8fa:	00000797          	auipc	a5,0x0
 8fe:	71678793          	addi	a5,a5,1814 # 1010 <base>
 902:	00000717          	auipc	a4,0x0
 906:	6ef73f23          	sd	a5,1790(a4) # 1000 <freep>
 90a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 90c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 910:	b7c1                	j	8d0 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 912:	6398                	ld	a4,0(a5)
 914:	e118                	sd	a4,0(a0)
 916:	a8a9                	j	970 <malloc+0xd6>
  hp->s.size = nu;
 918:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 91c:	0541                	addi	a0,a0,16
 91e:	efbff0ef          	jal	818 <free>
  return freep;
 922:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 926:	c12d                	beqz	a0,988 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 928:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 92a:	4798                	lw	a4,8(a5)
 92c:	02977263          	bgeu	a4,s1,950 <malloc+0xb6>
    if(p == freep)
 930:	00093703          	ld	a4,0(s2)
 934:	853e                	mv	a0,a5
 936:	fef719e3          	bne	a4,a5,928 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 93a:	8552                	mv	a0,s4
 93c:	b1bff0ef          	jal	456 <sbrk>
  if(p == (char*)-1)
 940:	fd551ce3          	bne	a0,s5,918 <malloc+0x7e>
        return 0;
 944:	4501                	li	a0,0
 946:	7902                	ld	s2,32(sp)
 948:	6a42                	ld	s4,16(sp)
 94a:	6aa2                	ld	s5,8(sp)
 94c:	6b02                	ld	s6,0(sp)
 94e:	a03d                	j	97c <malloc+0xe2>
 950:	7902                	ld	s2,32(sp)
 952:	6a42                	ld	s4,16(sp)
 954:	6aa2                	ld	s5,8(sp)
 956:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 958:	fae48de3          	beq	s1,a4,912 <malloc+0x78>
        p->s.size -= nunits;
 95c:	4137073b          	subw	a4,a4,s3
 960:	c798                	sw	a4,8(a5)
        p += p->s.size;
 962:	02071693          	slli	a3,a4,0x20
 966:	01c6d713          	srli	a4,a3,0x1c
 96a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 96c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 970:	00000717          	auipc	a4,0x0
 974:	68a73823          	sd	a0,1680(a4) # 1000 <freep>
      return (void*)(p + 1);
 978:	01078513          	addi	a0,a5,16
  }
}
 97c:	70e2                	ld	ra,56(sp)
 97e:	7442                	ld	s0,48(sp)
 980:	74a2                	ld	s1,40(sp)
 982:	69e2                	ld	s3,24(sp)
 984:	6121                	addi	sp,sp,64
 986:	8082                	ret
 988:	7902                	ld	s2,32(sp)
 98a:	6a42                	ld	s4,16(sp)
 98c:	6aa2                	ld	s5,8(sp)
 98e:	6b02                	ld	s6,0(sp)
 990:	b7f5                	j	97c <malloc+0xe2>
