
user/_grind：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	addi	a0,a0,-96 # 2000 <rand_next>
      68:	f99ff0ef          	jal	0 <do_rand>
}
      6c:	60a2                	ld	ra,8(sp)
      6e:	6402                	ld	s0,0(sp)
      70:	0141                	addi	sp,sp,16
      72:	8082                	ret

0000000000000074 <go>:

void
go(int which_child)
{
      74:	7119                	addi	sp,sp,-128
      76:	fc86                	sd	ra,120(sp)
      78:	f8a2                	sd	s0,112(sp)
      7a:	f4a6                	sd	s1,104(sp)
      7c:	e4d6                	sd	s5,72(sp)
      7e:	0100                	addi	s0,sp,128
      80:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      82:	4501                	li	a0,0
      84:	353000ef          	jal	bd6 <sbrk>
      88:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      8a:	00001517          	auipc	a0,0x1
      8e:	09650513          	addi	a0,a0,150 # 1120 <malloc+0x106>
      92:	325000ef          	jal	bb6 <mkdir>
  if(chdir("grindir") != 0){
      96:	00001517          	auipc	a0,0x1
      9a:	08a50513          	addi	a0,a0,138 # 1120 <malloc+0x106>
      9e:	321000ef          	jal	bbe <chdir>
      a2:	cd19                	beqz	a0,c0 <go+0x4c>
      a4:	f0ca                	sd	s2,96(sp)
      a6:	ecce                	sd	s3,88(sp)
      a8:	e8d2                	sd	s4,80(sp)
      aa:	e0da                	sd	s6,64(sp)
      ac:	fc5e                	sd	s7,56(sp)
    printf("grind: chdir grindir failed\n");
      ae:	00001517          	auipc	a0,0x1
      b2:	07a50513          	addi	a0,a0,122 # 1128 <malloc+0x10e>
      b6:	6b1000ef          	jal	f66 <printf>
    exit(1);
      ba:	4505                	li	a0,1
      bc:	293000ef          	jal	b4e <exit>
      c0:	f0ca                	sd	s2,96(sp)
      c2:	ecce                	sd	s3,88(sp)
      c4:	e8d2                	sd	s4,80(sp)
      c6:	e0da                	sd	s6,64(sp)
      c8:	fc5e                	sd	s7,56(sp)
  }
  chdir("/");
      ca:	00001517          	auipc	a0,0x1
      ce:	08650513          	addi	a0,a0,134 # 1150 <malloc+0x136>
      d2:	2ed000ef          	jal	bbe <chdir>
      d6:	00001997          	auipc	s3,0x1
      da:	08a98993          	addi	s3,s3,138 # 1160 <malloc+0x146>
      de:	c489                	beqz	s1,e8 <go+0x74>
      e0:	00001997          	auipc	s3,0x1
      e4:	07898993          	addi	s3,s3,120 # 1158 <malloc+0x13e>
  uint64 iters = 0;
      e8:	4481                	li	s1,0
  int fd = -1;
      ea:	5a7d                	li	s4,-1
      ec:	00001917          	auipc	s2,0x1
      f0:	34490913          	addi	s2,s2,836 # 1430 <malloc+0x416>
      f4:	a819                	j	10a <go+0x96>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
      f6:	20200593          	li	a1,514
      fa:	00001517          	auipc	a0,0x1
      fe:	06e50513          	addi	a0,a0,110 # 1168 <malloc+0x14e>
     102:	28d000ef          	jal	b8e <open>
     106:	271000ef          	jal	b76 <close>
    iters++;
     10a:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     10c:	1f400793          	li	a5,500
     110:	02f4f7b3          	remu	a5,s1,a5
     114:	e791                	bnez	a5,120 <go+0xac>
      write(1, which_child?"B":"A", 1);
     116:	4605                	li	a2,1
     118:	85ce                	mv	a1,s3
     11a:	4505                	li	a0,1
     11c:	253000ef          	jal	b6e <write>
    int what = rand() % 23;
     120:	f39ff0ef          	jal	58 <rand>
     124:	47dd                	li	a5,23
     126:	02f5653b          	remw	a0,a0,a5
     12a:	0005071b          	sext.w	a4,a0
     12e:	47d9                	li	a5,22
     130:	fce7ede3          	bltu	a5,a4,10a <go+0x96>
     134:	02051793          	slli	a5,a0,0x20
     138:	01e7d513          	srli	a0,a5,0x1e
     13c:	954a                	add	a0,a0,s2
     13e:	411c                	lw	a5,0(a0)
     140:	97ca                	add	a5,a5,s2
     142:	8782                	jr	a5
    } else if(what == 2){
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     144:	20200593          	li	a1,514
     148:	00001517          	auipc	a0,0x1
     14c:	03050513          	addi	a0,a0,48 # 1178 <malloc+0x15e>
     150:	23f000ef          	jal	b8e <open>
     154:	223000ef          	jal	b76 <close>
     158:	bf4d                	j	10a <go+0x96>
    } else if(what == 3){
      unlink("grindir/../a");
     15a:	00001517          	auipc	a0,0x1
     15e:	00e50513          	addi	a0,a0,14 # 1168 <malloc+0x14e>
     162:	23d000ef          	jal	b9e <unlink>
     166:	b755                	j	10a <go+0x96>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     168:	00001517          	auipc	a0,0x1
     16c:	fb850513          	addi	a0,a0,-72 # 1120 <malloc+0x106>
     170:	24f000ef          	jal	bbe <chdir>
     174:	ed11                	bnez	a0,190 <go+0x11c>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     176:	00001517          	auipc	a0,0x1
     17a:	01a50513          	addi	a0,a0,26 # 1190 <malloc+0x176>
     17e:	221000ef          	jal	b9e <unlink>
      chdir("/");
     182:	00001517          	auipc	a0,0x1
     186:	fce50513          	addi	a0,a0,-50 # 1150 <malloc+0x136>
     18a:	235000ef          	jal	bbe <chdir>
     18e:	bfb5                	j	10a <go+0x96>
        printf("grind: chdir grindir failed\n");
     190:	00001517          	auipc	a0,0x1
     194:	f9850513          	addi	a0,a0,-104 # 1128 <malloc+0x10e>
     198:	5cf000ef          	jal	f66 <printf>
        exit(1);
     19c:	4505                	li	a0,1
     19e:	1b1000ef          	jal	b4e <exit>
    } else if(what == 5){
      close(fd);
     1a2:	8552                	mv	a0,s4
     1a4:	1d3000ef          	jal	b76 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1a8:	20200593          	li	a1,514
     1ac:	00001517          	auipc	a0,0x1
     1b0:	fec50513          	addi	a0,a0,-20 # 1198 <malloc+0x17e>
     1b4:	1db000ef          	jal	b8e <open>
     1b8:	8a2a                	mv	s4,a0
     1ba:	bf81                	j	10a <go+0x96>
    } else if(what == 6){
      close(fd);
     1bc:	8552                	mv	a0,s4
     1be:	1b9000ef          	jal	b76 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     1c2:	20200593          	li	a1,514
     1c6:	00001517          	auipc	a0,0x1
     1ca:	fe250513          	addi	a0,a0,-30 # 11a8 <malloc+0x18e>
     1ce:	1c1000ef          	jal	b8e <open>
     1d2:	8a2a                	mv	s4,a0
     1d4:	bf1d                	j	10a <go+0x96>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     1d6:	3e700613          	li	a2,999
     1da:	00002597          	auipc	a1,0x2
     1de:	e4658593          	addi	a1,a1,-442 # 2020 <buf.0>
     1e2:	8552                	mv	a0,s4
     1e4:	18b000ef          	jal	b6e <write>
     1e8:	b70d                	j	10a <go+0x96>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     1ea:	3e700613          	li	a2,999
     1ee:	00002597          	auipc	a1,0x2
     1f2:	e3258593          	addi	a1,a1,-462 # 2020 <buf.0>
     1f6:	8552                	mv	a0,s4
     1f8:	16f000ef          	jal	b66 <read>
     1fc:	b739                	j	10a <go+0x96>
    } else if(what == 9){
      mkdir("grindir/../a");
     1fe:	00001517          	auipc	a0,0x1
     202:	f6a50513          	addi	a0,a0,-150 # 1168 <malloc+0x14e>
     206:	1b1000ef          	jal	bb6 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     20a:	20200593          	li	a1,514
     20e:	00001517          	auipc	a0,0x1
     212:	fb250513          	addi	a0,a0,-78 # 11c0 <malloc+0x1a6>
     216:	179000ef          	jal	b8e <open>
     21a:	15d000ef          	jal	b76 <close>
      unlink("a/a");
     21e:	00001517          	auipc	a0,0x1
     222:	fb250513          	addi	a0,a0,-78 # 11d0 <malloc+0x1b6>
     226:	179000ef          	jal	b9e <unlink>
     22a:	b5c5                	j	10a <go+0x96>
    } else if(what == 10){
      mkdir("/../b");
     22c:	00001517          	auipc	a0,0x1
     230:	fac50513          	addi	a0,a0,-84 # 11d8 <malloc+0x1be>
     234:	183000ef          	jal	bb6 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     238:	20200593          	li	a1,514
     23c:	00001517          	auipc	a0,0x1
     240:	fa450513          	addi	a0,a0,-92 # 11e0 <malloc+0x1c6>
     244:	14b000ef          	jal	b8e <open>
     248:	12f000ef          	jal	b76 <close>
      unlink("b/b");
     24c:	00001517          	auipc	a0,0x1
     250:	fa450513          	addi	a0,a0,-92 # 11f0 <malloc+0x1d6>
     254:	14b000ef          	jal	b9e <unlink>
     258:	bd4d                	j	10a <go+0x96>
    } else if(what == 11){
      unlink("b");
     25a:	00001517          	auipc	a0,0x1
     25e:	f9e50513          	addi	a0,a0,-98 # 11f8 <malloc+0x1de>
     262:	13d000ef          	jal	b9e <unlink>
      link("../grindir/./../a", "../b");
     266:	00001597          	auipc	a1,0x1
     26a:	f2a58593          	addi	a1,a1,-214 # 1190 <malloc+0x176>
     26e:	00001517          	auipc	a0,0x1
     272:	f9250513          	addi	a0,a0,-110 # 1200 <malloc+0x1e6>
     276:	139000ef          	jal	bae <link>
     27a:	bd41                	j	10a <go+0x96>
    } else if(what == 12){
      unlink("../grindir/../a");
     27c:	00001517          	auipc	a0,0x1
     280:	f9c50513          	addi	a0,a0,-100 # 1218 <malloc+0x1fe>
     284:	11b000ef          	jal	b9e <unlink>
      link(".././b", "/grindir/../a");
     288:	00001597          	auipc	a1,0x1
     28c:	f1058593          	addi	a1,a1,-240 # 1198 <malloc+0x17e>
     290:	00001517          	auipc	a0,0x1
     294:	f9850513          	addi	a0,a0,-104 # 1228 <malloc+0x20e>
     298:	117000ef          	jal	bae <link>
     29c:	b5bd                	j	10a <go+0x96>
    } else if(what == 13){
      int pid = fork();
     29e:	0a9000ef          	jal	b46 <fork>
      if(pid == 0){
     2a2:	c519                	beqz	a0,2b0 <go+0x23c>
        exit(0);
      } else if(pid < 0){
     2a4:	00054863          	bltz	a0,2b4 <go+0x240>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2a8:	4501                	li	a0,0
     2aa:	0ad000ef          	jal	b56 <wait>
     2ae:	bdb1                	j	10a <go+0x96>
        exit(0);
     2b0:	09f000ef          	jal	b4e <exit>
        printf("grind: fork failed\n");
     2b4:	00001517          	auipc	a0,0x1
     2b8:	f7c50513          	addi	a0,a0,-132 # 1230 <malloc+0x216>
     2bc:	4ab000ef          	jal	f66 <printf>
        exit(1);
     2c0:	4505                	li	a0,1
     2c2:	08d000ef          	jal	b4e <exit>
    } else if(what == 14){
      int pid = fork();
     2c6:	081000ef          	jal	b46 <fork>
      if(pid == 0){
     2ca:	c519                	beqz	a0,2d8 <go+0x264>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     2cc:	00054d63          	bltz	a0,2e6 <go+0x272>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2d0:	4501                	li	a0,0
     2d2:	085000ef          	jal	b56 <wait>
     2d6:	bd15                	j	10a <go+0x96>
        fork();
     2d8:	06f000ef          	jal	b46 <fork>
        fork();
     2dc:	06b000ef          	jal	b46 <fork>
        exit(0);
     2e0:	4501                	li	a0,0
     2e2:	06d000ef          	jal	b4e <exit>
        printf("grind: fork failed\n");
     2e6:	00001517          	auipc	a0,0x1
     2ea:	f4a50513          	addi	a0,a0,-182 # 1230 <malloc+0x216>
     2ee:	479000ef          	jal	f66 <printf>
        exit(1);
     2f2:	4505                	li	a0,1
     2f4:	05b000ef          	jal	b4e <exit>
    } else if(what == 15){
      sbrk(6011);
     2f8:	6505                	lui	a0,0x1
     2fa:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x2eb>
     2fe:	0d9000ef          	jal	bd6 <sbrk>
     302:	b521                	j	10a <go+0x96>
    } else if(what == 16){
      if(sbrk(0) > break0)
     304:	4501                	li	a0,0
     306:	0d1000ef          	jal	bd6 <sbrk>
     30a:	e0aaf0e3          	bgeu	s5,a0,10a <go+0x96>
        sbrk(-(sbrk(0) - break0));
     30e:	4501                	li	a0,0
     310:	0c7000ef          	jal	bd6 <sbrk>
     314:	40aa853b          	subw	a0,s5,a0
     318:	0bf000ef          	jal	bd6 <sbrk>
     31c:	b3fd                	j	10a <go+0x96>
    } else if(what == 17){
      int pid = fork();
     31e:	029000ef          	jal	b46 <fork>
     322:	8b2a                	mv	s6,a0
      if(pid == 0){
     324:	c10d                	beqz	a0,346 <go+0x2d2>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     326:	02054d63          	bltz	a0,360 <go+0x2ec>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     32a:	00001517          	auipc	a0,0x1
     32e:	f2650513          	addi	a0,a0,-218 # 1250 <malloc+0x236>
     332:	08d000ef          	jal	bbe <chdir>
     336:	ed15                	bnez	a0,372 <go+0x2fe>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     338:	855a                	mv	a0,s6
     33a:	045000ef          	jal	b7e <kill>
      wait(0);
     33e:	4501                	li	a0,0
     340:	017000ef          	jal	b56 <wait>
     344:	b3d9                	j	10a <go+0x96>
        close(open("a", O_CREATE|O_RDWR));
     346:	20200593          	li	a1,514
     34a:	00001517          	auipc	a0,0x1
     34e:	efe50513          	addi	a0,a0,-258 # 1248 <malloc+0x22e>
     352:	03d000ef          	jal	b8e <open>
     356:	021000ef          	jal	b76 <close>
        exit(0);
     35a:	4501                	li	a0,0
     35c:	7f2000ef          	jal	b4e <exit>
        printf("grind: fork failed\n");
     360:	00001517          	auipc	a0,0x1
     364:	ed050513          	addi	a0,a0,-304 # 1230 <malloc+0x216>
     368:	3ff000ef          	jal	f66 <printf>
        exit(1);
     36c:	4505                	li	a0,1
     36e:	7e0000ef          	jal	b4e <exit>
        printf("grind: chdir failed\n");
     372:	00001517          	auipc	a0,0x1
     376:	eee50513          	addi	a0,a0,-274 # 1260 <malloc+0x246>
     37a:	3ed000ef          	jal	f66 <printf>
        exit(1);
     37e:	4505                	li	a0,1
     380:	7ce000ef          	jal	b4e <exit>
    } else if(what == 18){
      int pid = fork();
     384:	7c2000ef          	jal	b46 <fork>
      if(pid == 0){
     388:	c519                	beqz	a0,396 <go+0x322>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     38a:	00054d63          	bltz	a0,3a4 <go+0x330>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     38e:	4501                	li	a0,0
     390:	7c6000ef          	jal	b56 <wait>
     394:	bb9d                	j	10a <go+0x96>
        kill(getpid());
     396:	039000ef          	jal	bce <getpid>
     39a:	7e4000ef          	jal	b7e <kill>
        exit(0);
     39e:	4501                	li	a0,0
     3a0:	7ae000ef          	jal	b4e <exit>
        printf("grind: fork failed\n");
     3a4:	00001517          	auipc	a0,0x1
     3a8:	e8c50513          	addi	a0,a0,-372 # 1230 <malloc+0x216>
     3ac:	3bb000ef          	jal	f66 <printf>
        exit(1);
     3b0:	4505                	li	a0,1
     3b2:	79c000ef          	jal	b4e <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     3b6:	f9840513          	addi	a0,s0,-104
     3ba:	7a4000ef          	jal	b5e <pipe>
     3be:	02054363          	bltz	a0,3e4 <go+0x370>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     3c2:	784000ef          	jal	b46 <fork>
      if(pid == 0){
     3c6:	c905                	beqz	a0,3f6 <go+0x382>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     3c8:	08054263          	bltz	a0,44c <go+0x3d8>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     3cc:	f9842503          	lw	a0,-104(s0)
     3d0:	7a6000ef          	jal	b76 <close>
      close(fds[1]);
     3d4:	f9c42503          	lw	a0,-100(s0)
     3d8:	79e000ef          	jal	b76 <close>
      wait(0);
     3dc:	4501                	li	a0,0
     3de:	778000ef          	jal	b56 <wait>
     3e2:	b325                	j	10a <go+0x96>
        printf("grind: pipe failed\n");
     3e4:	00001517          	auipc	a0,0x1
     3e8:	e9450513          	addi	a0,a0,-364 # 1278 <malloc+0x25e>
     3ec:	37b000ef          	jal	f66 <printf>
        exit(1);
     3f0:	4505                	li	a0,1
     3f2:	75c000ef          	jal	b4e <exit>
        fork();
     3f6:	750000ef          	jal	b46 <fork>
        fork();
     3fa:	74c000ef          	jal	b46 <fork>
        if(write(fds[1], "x", 1) != 1)
     3fe:	4605                	li	a2,1
     400:	00001597          	auipc	a1,0x1
     404:	e9058593          	addi	a1,a1,-368 # 1290 <malloc+0x276>
     408:	f9c42503          	lw	a0,-100(s0)
     40c:	762000ef          	jal	b6e <write>
     410:	4785                	li	a5,1
     412:	00f51f63          	bne	a0,a5,430 <go+0x3bc>
        if(read(fds[0], &c, 1) != 1)
     416:	4605                	li	a2,1
     418:	f9040593          	addi	a1,s0,-112
     41c:	f9842503          	lw	a0,-104(s0)
     420:	746000ef          	jal	b66 <read>
     424:	4785                	li	a5,1
     426:	00f51c63          	bne	a0,a5,43e <go+0x3ca>
        exit(0);
     42a:	4501                	li	a0,0
     42c:	722000ef          	jal	b4e <exit>
          printf("grind: pipe write failed\n");
     430:	00001517          	auipc	a0,0x1
     434:	e6850513          	addi	a0,a0,-408 # 1298 <malloc+0x27e>
     438:	32f000ef          	jal	f66 <printf>
     43c:	bfe9                	j	416 <go+0x3a2>
          printf("grind: pipe read failed\n");
     43e:	00001517          	auipc	a0,0x1
     442:	e7a50513          	addi	a0,a0,-390 # 12b8 <malloc+0x29e>
     446:	321000ef          	jal	f66 <printf>
     44a:	b7c5                	j	42a <go+0x3b6>
        printf("grind: fork failed\n");
     44c:	00001517          	auipc	a0,0x1
     450:	de450513          	addi	a0,a0,-540 # 1230 <malloc+0x216>
     454:	313000ef          	jal	f66 <printf>
        exit(1);
     458:	4505                	li	a0,1
     45a:	6f4000ef          	jal	b4e <exit>
    } else if(what == 20){
      int pid = fork();
     45e:	6e8000ef          	jal	b46 <fork>
      if(pid == 0){
     462:	c519                	beqz	a0,470 <go+0x3fc>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     464:	04054f63          	bltz	a0,4c2 <go+0x44e>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     468:	4501                	li	a0,0
     46a:	6ec000ef          	jal	b56 <wait>
     46e:	b971                	j	10a <go+0x96>
        unlink("a");
     470:	00001517          	auipc	a0,0x1
     474:	dd850513          	addi	a0,a0,-552 # 1248 <malloc+0x22e>
     478:	726000ef          	jal	b9e <unlink>
        mkdir("a");
     47c:	00001517          	auipc	a0,0x1
     480:	dcc50513          	addi	a0,a0,-564 # 1248 <malloc+0x22e>
     484:	732000ef          	jal	bb6 <mkdir>
        chdir("a");
     488:	00001517          	auipc	a0,0x1
     48c:	dc050513          	addi	a0,a0,-576 # 1248 <malloc+0x22e>
     490:	72e000ef          	jal	bbe <chdir>
        unlink("../a");
     494:	00001517          	auipc	a0,0x1
     498:	e4450513          	addi	a0,a0,-444 # 12d8 <malloc+0x2be>
     49c:	702000ef          	jal	b9e <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     4a0:	20200593          	li	a1,514
     4a4:	00001517          	auipc	a0,0x1
     4a8:	dec50513          	addi	a0,a0,-532 # 1290 <malloc+0x276>
     4ac:	6e2000ef          	jal	b8e <open>
        unlink("x");
     4b0:	00001517          	auipc	a0,0x1
     4b4:	de050513          	addi	a0,a0,-544 # 1290 <malloc+0x276>
     4b8:	6e6000ef          	jal	b9e <unlink>
        exit(0);
     4bc:	4501                	li	a0,0
     4be:	690000ef          	jal	b4e <exit>
        printf("grind: fork failed\n");
     4c2:	00001517          	auipc	a0,0x1
     4c6:	d6e50513          	addi	a0,a0,-658 # 1230 <malloc+0x216>
     4ca:	29d000ef          	jal	f66 <printf>
        exit(1);
     4ce:	4505                	li	a0,1
     4d0:	67e000ef          	jal	b4e <exit>
    } else if(what == 21){
      unlink("c");
     4d4:	00001517          	auipc	a0,0x1
     4d8:	e0c50513          	addi	a0,a0,-500 # 12e0 <malloc+0x2c6>
     4dc:	6c2000ef          	jal	b9e <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     4e0:	20200593          	li	a1,514
     4e4:	00001517          	auipc	a0,0x1
     4e8:	dfc50513          	addi	a0,a0,-516 # 12e0 <malloc+0x2c6>
     4ec:	6a2000ef          	jal	b8e <open>
     4f0:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     4f2:	04054763          	bltz	a0,540 <go+0x4cc>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     4f6:	4605                	li	a2,1
     4f8:	00001597          	auipc	a1,0x1
     4fc:	d9858593          	addi	a1,a1,-616 # 1290 <malloc+0x276>
     500:	66e000ef          	jal	b6e <write>
     504:	4785                	li	a5,1
     506:	04f51663          	bne	a0,a5,552 <go+0x4de>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     50a:	f9840593          	addi	a1,s0,-104
     50e:	855a                	mv	a0,s6
     510:	696000ef          	jal	ba6 <fstat>
     514:	e921                	bnez	a0,564 <go+0x4f0>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     516:	fa843583          	ld	a1,-88(s0)
     51a:	4785                	li	a5,1
     51c:	04f59d63          	bne	a1,a5,576 <go+0x502>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     520:	f9c42583          	lw	a1,-100(s0)
     524:	0c800793          	li	a5,200
     528:	06b7e163          	bltu	a5,a1,58a <go+0x516>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     52c:	855a                	mv	a0,s6
     52e:	648000ef          	jal	b76 <close>
      unlink("c");
     532:	00001517          	auipc	a0,0x1
     536:	dae50513          	addi	a0,a0,-594 # 12e0 <malloc+0x2c6>
     53a:	664000ef          	jal	b9e <unlink>
     53e:	b6f1                	j	10a <go+0x96>
        printf("grind: create c failed\n");
     540:	00001517          	auipc	a0,0x1
     544:	da850513          	addi	a0,a0,-600 # 12e8 <malloc+0x2ce>
     548:	21f000ef          	jal	f66 <printf>
        exit(1);
     54c:	4505                	li	a0,1
     54e:	600000ef          	jal	b4e <exit>
        printf("grind: write c failed\n");
     552:	00001517          	auipc	a0,0x1
     556:	dae50513          	addi	a0,a0,-594 # 1300 <malloc+0x2e6>
     55a:	20d000ef          	jal	f66 <printf>
        exit(1);
     55e:	4505                	li	a0,1
     560:	5ee000ef          	jal	b4e <exit>
        printf("grind: fstat failed\n");
     564:	00001517          	auipc	a0,0x1
     568:	db450513          	addi	a0,a0,-588 # 1318 <malloc+0x2fe>
     56c:	1fb000ef          	jal	f66 <printf>
        exit(1);
     570:	4505                	li	a0,1
     572:	5dc000ef          	jal	b4e <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     576:	2581                	sext.w	a1,a1
     578:	00001517          	auipc	a0,0x1
     57c:	db850513          	addi	a0,a0,-584 # 1330 <malloc+0x316>
     580:	1e7000ef          	jal	f66 <printf>
        exit(1);
     584:	4505                	li	a0,1
     586:	5c8000ef          	jal	b4e <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     58a:	00001517          	auipc	a0,0x1
     58e:	dce50513          	addi	a0,a0,-562 # 1358 <malloc+0x33e>
     592:	1d5000ef          	jal	f66 <printf>
        exit(1);
     596:	4505                	li	a0,1
     598:	5b6000ef          	jal	b4e <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     59c:	f8840513          	addi	a0,s0,-120
     5a0:	5be000ef          	jal	b5e <pipe>
     5a4:	0a054563          	bltz	a0,64e <go+0x5da>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     5a8:	f9040513          	addi	a0,s0,-112
     5ac:	5b2000ef          	jal	b5e <pipe>
     5b0:	0a054963          	bltz	a0,662 <go+0x5ee>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     5b4:	592000ef          	jal	b46 <fork>
      if(pid1 == 0){
     5b8:	cd5d                	beqz	a0,676 <go+0x602>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     5ba:	14054263          	bltz	a0,6fe <go+0x68a>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     5be:	588000ef          	jal	b46 <fork>
      if(pid2 == 0){
     5c2:	14050863          	beqz	a0,712 <go+0x69e>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     5c6:	1e054663          	bltz	a0,7b2 <go+0x73e>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     5ca:	f8842503          	lw	a0,-120(s0)
     5ce:	5a8000ef          	jal	b76 <close>
      close(aa[1]);
     5d2:	f8c42503          	lw	a0,-116(s0)
     5d6:	5a0000ef          	jal	b76 <close>
      close(bb[1]);
     5da:	f9442503          	lw	a0,-108(s0)
     5de:	598000ef          	jal	b76 <close>
      char buf[4] = { 0, 0, 0, 0 };
     5e2:	f8042023          	sw	zero,-128(s0)
      read(bb[0], buf+0, 1);
     5e6:	4605                	li	a2,1
     5e8:	f8040593          	addi	a1,s0,-128
     5ec:	f9042503          	lw	a0,-112(s0)
     5f0:	576000ef          	jal	b66 <read>
      read(bb[0], buf+1, 1);
     5f4:	4605                	li	a2,1
     5f6:	f8140593          	addi	a1,s0,-127
     5fa:	f9042503          	lw	a0,-112(s0)
     5fe:	568000ef          	jal	b66 <read>
      read(bb[0], buf+2, 1);
     602:	4605                	li	a2,1
     604:	f8240593          	addi	a1,s0,-126
     608:	f9042503          	lw	a0,-112(s0)
     60c:	55a000ef          	jal	b66 <read>
      close(bb[0]);
     610:	f9042503          	lw	a0,-112(s0)
     614:	562000ef          	jal	b76 <close>
      int st1, st2;
      wait(&st1);
     618:	f8440513          	addi	a0,s0,-124
     61c:	53a000ef          	jal	b56 <wait>
      wait(&st2);
     620:	f9840513          	addi	a0,s0,-104
     624:	532000ef          	jal	b56 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     628:	f8442783          	lw	a5,-124(s0)
     62c:	f9842b83          	lw	s7,-104(s0)
     630:	0177eb33          	or	s6,a5,s7
     634:	180b1963          	bnez	s6,7c6 <go+0x752>
     638:	00001597          	auipc	a1,0x1
     63c:	dc058593          	addi	a1,a1,-576 # 13f8 <malloc+0x3de>
     640:	f8040513          	addi	a0,s0,-128
     644:	2ce000ef          	jal	912 <strcmp>
     648:	ac0501e3          	beqz	a0,10a <go+0x96>
     64c:	aab5                	j	7c8 <go+0x754>
        fprintf(2, "grind: pipe failed\n");
     64e:	00001597          	auipc	a1,0x1
     652:	c2a58593          	addi	a1,a1,-982 # 1278 <malloc+0x25e>
     656:	4509                	li	a0,2
     658:	0e5000ef          	jal	f3c <fprintf>
        exit(1);
     65c:	4505                	li	a0,1
     65e:	4f0000ef          	jal	b4e <exit>
        fprintf(2, "grind: pipe failed\n");
     662:	00001597          	auipc	a1,0x1
     666:	c1658593          	addi	a1,a1,-1002 # 1278 <malloc+0x25e>
     66a:	4509                	li	a0,2
     66c:	0d1000ef          	jal	f3c <fprintf>
        exit(1);
     670:	4505                	li	a0,1
     672:	4dc000ef          	jal	b4e <exit>
        close(bb[0]);
     676:	f9042503          	lw	a0,-112(s0)
     67a:	4fc000ef          	jal	b76 <close>
        close(bb[1]);
     67e:	f9442503          	lw	a0,-108(s0)
     682:	4f4000ef          	jal	b76 <close>
        close(aa[0]);
     686:	f8842503          	lw	a0,-120(s0)
     68a:	4ec000ef          	jal	b76 <close>
        close(1);
     68e:	4505                	li	a0,1
     690:	4e6000ef          	jal	b76 <close>
        if(dup(aa[1]) != 1){
     694:	f8c42503          	lw	a0,-116(s0)
     698:	52e000ef          	jal	bc6 <dup>
     69c:	4785                	li	a5,1
     69e:	00f50c63          	beq	a0,a5,6b6 <go+0x642>
          fprintf(2, "grind: dup failed\n");
     6a2:	00001597          	auipc	a1,0x1
     6a6:	cde58593          	addi	a1,a1,-802 # 1380 <malloc+0x366>
     6aa:	4509                	li	a0,2
     6ac:	091000ef          	jal	f3c <fprintf>
          exit(1);
     6b0:	4505                	li	a0,1
     6b2:	49c000ef          	jal	b4e <exit>
        close(aa[1]);
     6b6:	f8c42503          	lw	a0,-116(s0)
     6ba:	4bc000ef          	jal	b76 <close>
        char *args[3] = { "echo", "hi", 0 };
     6be:	00001797          	auipc	a5,0x1
     6c2:	cda78793          	addi	a5,a5,-806 # 1398 <malloc+0x37e>
     6c6:	f8f43c23          	sd	a5,-104(s0)
     6ca:	00001797          	auipc	a5,0x1
     6ce:	cd678793          	addi	a5,a5,-810 # 13a0 <malloc+0x386>
     6d2:	faf43023          	sd	a5,-96(s0)
     6d6:	fa043423          	sd	zero,-88(s0)
        exec("grindir/../echo", args);
     6da:	f9840593          	addi	a1,s0,-104
     6de:	00001517          	auipc	a0,0x1
     6e2:	cca50513          	addi	a0,a0,-822 # 13a8 <malloc+0x38e>
     6e6:	4a0000ef          	jal	b86 <exec>
        fprintf(2, "grind: echo: not found\n");
     6ea:	00001597          	auipc	a1,0x1
     6ee:	cce58593          	addi	a1,a1,-818 # 13b8 <malloc+0x39e>
     6f2:	4509                	li	a0,2
     6f4:	049000ef          	jal	f3c <fprintf>
        exit(2);
     6f8:	4509                	li	a0,2
     6fa:	454000ef          	jal	b4e <exit>
        fprintf(2, "grind: fork failed\n");
     6fe:	00001597          	auipc	a1,0x1
     702:	b3258593          	addi	a1,a1,-1230 # 1230 <malloc+0x216>
     706:	4509                	li	a0,2
     708:	035000ef          	jal	f3c <fprintf>
        exit(3);
     70c:	450d                	li	a0,3
     70e:	440000ef          	jal	b4e <exit>
        close(aa[1]);
     712:	f8c42503          	lw	a0,-116(s0)
     716:	460000ef          	jal	b76 <close>
        close(bb[0]);
     71a:	f9042503          	lw	a0,-112(s0)
     71e:	458000ef          	jal	b76 <close>
        close(0);
     722:	4501                	li	a0,0
     724:	452000ef          	jal	b76 <close>
        if(dup(aa[0]) != 0){
     728:	f8842503          	lw	a0,-120(s0)
     72c:	49a000ef          	jal	bc6 <dup>
     730:	c919                	beqz	a0,746 <go+0x6d2>
          fprintf(2, "grind: dup failed\n");
     732:	00001597          	auipc	a1,0x1
     736:	c4e58593          	addi	a1,a1,-946 # 1380 <malloc+0x366>
     73a:	4509                	li	a0,2
     73c:	001000ef          	jal	f3c <fprintf>
          exit(4);
     740:	4511                	li	a0,4
     742:	40c000ef          	jal	b4e <exit>
        close(aa[0]);
     746:	f8842503          	lw	a0,-120(s0)
     74a:	42c000ef          	jal	b76 <close>
        close(1);
     74e:	4505                	li	a0,1
     750:	426000ef          	jal	b76 <close>
        if(dup(bb[1]) != 1){
     754:	f9442503          	lw	a0,-108(s0)
     758:	46e000ef          	jal	bc6 <dup>
     75c:	4785                	li	a5,1
     75e:	00f50c63          	beq	a0,a5,776 <go+0x702>
          fprintf(2, "grind: dup failed\n");
     762:	00001597          	auipc	a1,0x1
     766:	c1e58593          	addi	a1,a1,-994 # 1380 <malloc+0x366>
     76a:	4509                	li	a0,2
     76c:	7d0000ef          	jal	f3c <fprintf>
          exit(5);
     770:	4515                	li	a0,5
     772:	3dc000ef          	jal	b4e <exit>
        close(bb[1]);
     776:	f9442503          	lw	a0,-108(s0)
     77a:	3fc000ef          	jal	b76 <close>
        char *args[2] = { "cat", 0 };
     77e:	00001797          	auipc	a5,0x1
     782:	c5278793          	addi	a5,a5,-942 # 13d0 <malloc+0x3b6>
     786:	f8f43c23          	sd	a5,-104(s0)
     78a:	fa043023          	sd	zero,-96(s0)
        exec("/cat", args);
     78e:	f9840593          	addi	a1,s0,-104
     792:	00001517          	auipc	a0,0x1
     796:	c4650513          	addi	a0,a0,-954 # 13d8 <malloc+0x3be>
     79a:	3ec000ef          	jal	b86 <exec>
        fprintf(2, "grind: cat: not found\n");
     79e:	00001597          	auipc	a1,0x1
     7a2:	c4258593          	addi	a1,a1,-958 # 13e0 <malloc+0x3c6>
     7a6:	4509                	li	a0,2
     7a8:	794000ef          	jal	f3c <fprintf>
        exit(6);
     7ac:	4519                	li	a0,6
     7ae:	3a0000ef          	jal	b4e <exit>
        fprintf(2, "grind: fork failed\n");
     7b2:	00001597          	auipc	a1,0x1
     7b6:	a7e58593          	addi	a1,a1,-1410 # 1230 <malloc+0x216>
     7ba:	4509                	li	a0,2
     7bc:	780000ef          	jal	f3c <fprintf>
        exit(7);
     7c0:	451d                	li	a0,7
     7c2:	38c000ef          	jal	b4e <exit>
     7c6:	8b3e                	mv	s6,a5
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     7c8:	f8040693          	addi	a3,s0,-128
     7cc:	865e                	mv	a2,s7
     7ce:	85da                	mv	a1,s6
     7d0:	00001517          	auipc	a0,0x1
     7d4:	c3050513          	addi	a0,a0,-976 # 1400 <malloc+0x3e6>
     7d8:	78e000ef          	jal	f66 <printf>
        exit(1);
     7dc:	4505                	li	a0,1
     7de:	370000ef          	jal	b4e <exit>

00000000000007e2 <iter>:
  }
}

void
iter()
{
     7e2:	7179                	addi	sp,sp,-48
     7e4:	f406                	sd	ra,40(sp)
     7e6:	f022                	sd	s0,32(sp)
     7e8:	1800                	addi	s0,sp,48
  unlink("a");
     7ea:	00001517          	auipc	a0,0x1
     7ee:	a5e50513          	addi	a0,a0,-1442 # 1248 <malloc+0x22e>
     7f2:	3ac000ef          	jal	b9e <unlink>
  unlink("b");
     7f6:	00001517          	auipc	a0,0x1
     7fa:	a0250513          	addi	a0,a0,-1534 # 11f8 <malloc+0x1de>
     7fe:	3a0000ef          	jal	b9e <unlink>
  
  int pid1 = fork();
     802:	344000ef          	jal	b46 <fork>
  if(pid1 < 0){
     806:	02054163          	bltz	a0,828 <iter+0x46>
     80a:	ec26                	sd	s1,24(sp)
     80c:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     80e:	e905                	bnez	a0,83e <iter+0x5c>
     810:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     812:	00001717          	auipc	a4,0x1
     816:	7ee70713          	addi	a4,a4,2030 # 2000 <rand_next>
     81a:	631c                	ld	a5,0(a4)
     81c:	01f7c793          	xori	a5,a5,31
     820:	e31c                	sd	a5,0(a4)
    go(0);
     822:	4501                	li	a0,0
     824:	851ff0ef          	jal	74 <go>
     828:	ec26                	sd	s1,24(sp)
     82a:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     82c:	00001517          	auipc	a0,0x1
     830:	a0450513          	addi	a0,a0,-1532 # 1230 <malloc+0x216>
     834:	732000ef          	jal	f66 <printf>
    exit(1);
     838:	4505                	li	a0,1
     83a:	314000ef          	jal	b4e <exit>
     83e:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     840:	306000ef          	jal	b46 <fork>
     844:	892a                	mv	s2,a0
  if(pid2 < 0){
     846:	02054063          	bltz	a0,866 <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     84a:	e51d                	bnez	a0,878 <iter+0x96>
    rand_next ^= 7177;
     84c:	00001697          	auipc	a3,0x1
     850:	7b468693          	addi	a3,a3,1972 # 2000 <rand_next>
     854:	629c                	ld	a5,0(a3)
     856:	6709                	lui	a4,0x2
     858:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x779>
     85c:	8fb9                	xor	a5,a5,a4
     85e:	e29c                	sd	a5,0(a3)
    go(1);
     860:	4505                	li	a0,1
     862:	813ff0ef          	jal	74 <go>
    printf("grind: fork failed\n");
     866:	00001517          	auipc	a0,0x1
     86a:	9ca50513          	addi	a0,a0,-1590 # 1230 <malloc+0x216>
     86e:	6f8000ef          	jal	f66 <printf>
    exit(1);
     872:	4505                	li	a0,1
     874:	2da000ef          	jal	b4e <exit>
    exit(0);
  }

  int st1 = -1;
     878:	57fd                	li	a5,-1
     87a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     87e:	fdc40513          	addi	a0,s0,-36
     882:	2d4000ef          	jal	b56 <wait>
  if(st1 != 0){
     886:	fdc42783          	lw	a5,-36(s0)
     88a:	eb99                	bnez	a5,8a0 <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     88c:	57fd                	li	a5,-1
     88e:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     892:	fd840513          	addi	a0,s0,-40
     896:	2c0000ef          	jal	b56 <wait>

  exit(0);
     89a:	4501                	li	a0,0
     89c:	2b2000ef          	jal	b4e <exit>
    kill(pid1);
     8a0:	8526                	mv	a0,s1
     8a2:	2dc000ef          	jal	b7e <kill>
    kill(pid2);
     8a6:	854a                	mv	a0,s2
     8a8:	2d6000ef          	jal	b7e <kill>
     8ac:	b7c5                	j	88c <iter+0xaa>

00000000000008ae <main>:
}

int
main()
{
     8ae:	1101                	addi	sp,sp,-32
     8b0:	ec06                	sd	ra,24(sp)
     8b2:	e822                	sd	s0,16(sp)
     8b4:	e426                	sd	s1,8(sp)
     8b6:	1000                	addi	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
     8b8:	00001497          	auipc	s1,0x1
     8bc:	74848493          	addi	s1,s1,1864 # 2000 <rand_next>
     8c0:	a809                	j	8d2 <main+0x24>
      iter();
     8c2:	f21ff0ef          	jal	7e2 <iter>
    sleep(20);
     8c6:	4551                	li	a0,20
     8c8:	316000ef          	jal	bde <sleep>
    rand_next += 1;
     8cc:	609c                	ld	a5,0(s1)
     8ce:	0785                	addi	a5,a5,1
     8d0:	e09c                	sd	a5,0(s1)
    int pid = fork();
     8d2:	274000ef          	jal	b46 <fork>
    if(pid == 0){
     8d6:	d575                	beqz	a0,8c2 <main+0x14>
    if(pid > 0){
     8d8:	fea057e3          	blez	a0,8c6 <main+0x18>
      wait(0);
     8dc:	4501                	li	a0,0
     8de:	278000ef          	jal	b56 <wait>
     8e2:	b7d5                	j	8c6 <main+0x18>

00000000000008e4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     8e4:	1141                	addi	sp,sp,-16
     8e6:	e406                	sd	ra,8(sp)
     8e8:	e022                	sd	s0,0(sp)
     8ea:	0800                	addi	s0,sp,16
  extern int main();
  main();
     8ec:	fc3ff0ef          	jal	8ae <main>
  exit(0);
     8f0:	4501                	li	a0,0
     8f2:	25c000ef          	jal	b4e <exit>

00000000000008f6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     8f6:	1141                	addi	sp,sp,-16
     8f8:	e422                	sd	s0,8(sp)
     8fa:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     8fc:	87aa                	mv	a5,a0
     8fe:	0585                	addi	a1,a1,1
     900:	0785                	addi	a5,a5,1
     902:	fff5c703          	lbu	a4,-1(a1)
     906:	fee78fa3          	sb	a4,-1(a5)
     90a:	fb75                	bnez	a4,8fe <strcpy+0x8>
    ;
  return os;
}
     90c:	6422                	ld	s0,8(sp)
     90e:	0141                	addi	sp,sp,16
     910:	8082                	ret

0000000000000912 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     912:	1141                	addi	sp,sp,-16
     914:	e422                	sd	s0,8(sp)
     916:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     918:	00054783          	lbu	a5,0(a0)
     91c:	cb91                	beqz	a5,930 <strcmp+0x1e>
     91e:	0005c703          	lbu	a4,0(a1)
     922:	00f71763          	bne	a4,a5,930 <strcmp+0x1e>
    p++, q++;
     926:	0505                	addi	a0,a0,1
     928:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     92a:	00054783          	lbu	a5,0(a0)
     92e:	fbe5                	bnez	a5,91e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     930:	0005c503          	lbu	a0,0(a1)
}
     934:	40a7853b          	subw	a0,a5,a0
     938:	6422                	ld	s0,8(sp)
     93a:	0141                	addi	sp,sp,16
     93c:	8082                	ret

000000000000093e <strlen>:

uint
strlen(const char *s)
{
     93e:	1141                	addi	sp,sp,-16
     940:	e422                	sd	s0,8(sp)
     942:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     944:	00054783          	lbu	a5,0(a0)
     948:	cf91                	beqz	a5,964 <strlen+0x26>
     94a:	0505                	addi	a0,a0,1
     94c:	87aa                	mv	a5,a0
     94e:	86be                	mv	a3,a5
     950:	0785                	addi	a5,a5,1
     952:	fff7c703          	lbu	a4,-1(a5)
     956:	ff65                	bnez	a4,94e <strlen+0x10>
     958:	40a6853b          	subw	a0,a3,a0
     95c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     95e:	6422                	ld	s0,8(sp)
     960:	0141                	addi	sp,sp,16
     962:	8082                	ret
  for(n = 0; s[n]; n++)
     964:	4501                	li	a0,0
     966:	bfe5                	j	95e <strlen+0x20>

0000000000000968 <memset>:

void*
memset(void *dst, int c, uint n)
{
     968:	1141                	addi	sp,sp,-16
     96a:	e422                	sd	s0,8(sp)
     96c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     96e:	ca19                	beqz	a2,984 <memset+0x1c>
     970:	87aa                	mv	a5,a0
     972:	1602                	slli	a2,a2,0x20
     974:	9201                	srli	a2,a2,0x20
     976:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     97a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     97e:	0785                	addi	a5,a5,1
     980:	fee79de3          	bne	a5,a4,97a <memset+0x12>
  }
  return dst;
}
     984:	6422                	ld	s0,8(sp)
     986:	0141                	addi	sp,sp,16
     988:	8082                	ret

000000000000098a <strchr>:

char*
strchr(const char *s, char c)
{
     98a:	1141                	addi	sp,sp,-16
     98c:	e422                	sd	s0,8(sp)
     98e:	0800                	addi	s0,sp,16
  for(; *s; s++)
     990:	00054783          	lbu	a5,0(a0)
     994:	cb99                	beqz	a5,9aa <strchr+0x20>
    if(*s == c)
     996:	00f58763          	beq	a1,a5,9a4 <strchr+0x1a>
  for(; *s; s++)
     99a:	0505                	addi	a0,a0,1
     99c:	00054783          	lbu	a5,0(a0)
     9a0:	fbfd                	bnez	a5,996 <strchr+0xc>
      return (char*)s;
  return 0;
     9a2:	4501                	li	a0,0
}
     9a4:	6422                	ld	s0,8(sp)
     9a6:	0141                	addi	sp,sp,16
     9a8:	8082                	ret
  return 0;
     9aa:	4501                	li	a0,0
     9ac:	bfe5                	j	9a4 <strchr+0x1a>

00000000000009ae <gets>:

char*
gets(char *buf, int max)
{
     9ae:	711d                	addi	sp,sp,-96
     9b0:	ec86                	sd	ra,88(sp)
     9b2:	e8a2                	sd	s0,80(sp)
     9b4:	e4a6                	sd	s1,72(sp)
     9b6:	e0ca                	sd	s2,64(sp)
     9b8:	fc4e                	sd	s3,56(sp)
     9ba:	f852                	sd	s4,48(sp)
     9bc:	f456                	sd	s5,40(sp)
     9be:	f05a                	sd	s6,32(sp)
     9c0:	ec5e                	sd	s7,24(sp)
     9c2:	1080                	addi	s0,sp,96
     9c4:	8baa                	mv	s7,a0
     9c6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9c8:	892a                	mv	s2,a0
     9ca:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     9cc:	4aa9                	li	s5,10
     9ce:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     9d0:	89a6                	mv	s3,s1
     9d2:	2485                	addiw	s1,s1,1
     9d4:	0344d663          	bge	s1,s4,a00 <gets+0x52>
    cc = read(0, &c, 1);
     9d8:	4605                	li	a2,1
     9da:	faf40593          	addi	a1,s0,-81
     9de:	4501                	li	a0,0
     9e0:	186000ef          	jal	b66 <read>
    if(cc < 1)
     9e4:	00a05e63          	blez	a0,a00 <gets+0x52>
    buf[i++] = c;
     9e8:	faf44783          	lbu	a5,-81(s0)
     9ec:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     9f0:	01578763          	beq	a5,s5,9fe <gets+0x50>
     9f4:	0905                	addi	s2,s2,1
     9f6:	fd679de3          	bne	a5,s6,9d0 <gets+0x22>
    buf[i++] = c;
     9fa:	89a6                	mv	s3,s1
     9fc:	a011                	j	a00 <gets+0x52>
     9fe:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     a00:	99de                	add	s3,s3,s7
     a02:	00098023          	sb	zero,0(s3)
  return buf;
}
     a06:	855e                	mv	a0,s7
     a08:	60e6                	ld	ra,88(sp)
     a0a:	6446                	ld	s0,80(sp)
     a0c:	64a6                	ld	s1,72(sp)
     a0e:	6906                	ld	s2,64(sp)
     a10:	79e2                	ld	s3,56(sp)
     a12:	7a42                	ld	s4,48(sp)
     a14:	7aa2                	ld	s5,40(sp)
     a16:	7b02                	ld	s6,32(sp)
     a18:	6be2                	ld	s7,24(sp)
     a1a:	6125                	addi	sp,sp,96
     a1c:	8082                	ret

0000000000000a1e <stat>:

int
stat(const char *n, struct stat *st)
{
     a1e:	1101                	addi	sp,sp,-32
     a20:	ec06                	sd	ra,24(sp)
     a22:	e822                	sd	s0,16(sp)
     a24:	e04a                	sd	s2,0(sp)
     a26:	1000                	addi	s0,sp,32
     a28:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a2a:	4581                	li	a1,0
     a2c:	162000ef          	jal	b8e <open>
  if(fd < 0)
     a30:	02054263          	bltz	a0,a54 <stat+0x36>
     a34:	e426                	sd	s1,8(sp)
     a36:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     a38:	85ca                	mv	a1,s2
     a3a:	16c000ef          	jal	ba6 <fstat>
     a3e:	892a                	mv	s2,a0
  close(fd);
     a40:	8526                	mv	a0,s1
     a42:	134000ef          	jal	b76 <close>
  return r;
     a46:	64a2                	ld	s1,8(sp)
}
     a48:	854a                	mv	a0,s2
     a4a:	60e2                	ld	ra,24(sp)
     a4c:	6442                	ld	s0,16(sp)
     a4e:	6902                	ld	s2,0(sp)
     a50:	6105                	addi	sp,sp,32
     a52:	8082                	ret
    return -1;
     a54:	597d                	li	s2,-1
     a56:	bfcd                	j	a48 <stat+0x2a>

0000000000000a58 <atoi>:

int
atoi(const char *s)
{
     a58:	1141                	addi	sp,sp,-16
     a5a:	e422                	sd	s0,8(sp)
     a5c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     a5e:	00054683          	lbu	a3,0(a0)
     a62:	fd06879b          	addiw	a5,a3,-48
     a66:	0ff7f793          	zext.b	a5,a5
     a6a:	4625                	li	a2,9
     a6c:	02f66863          	bltu	a2,a5,a9c <atoi+0x44>
     a70:	872a                	mv	a4,a0
  n = 0;
     a72:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     a74:	0705                	addi	a4,a4,1
     a76:	0025179b          	slliw	a5,a0,0x2
     a7a:	9fa9                	addw	a5,a5,a0
     a7c:	0017979b          	slliw	a5,a5,0x1
     a80:	9fb5                	addw	a5,a5,a3
     a82:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     a86:	00074683          	lbu	a3,0(a4)
     a8a:	fd06879b          	addiw	a5,a3,-48
     a8e:	0ff7f793          	zext.b	a5,a5
     a92:	fef671e3          	bgeu	a2,a5,a74 <atoi+0x1c>
  return n;
}
     a96:	6422                	ld	s0,8(sp)
     a98:	0141                	addi	sp,sp,16
     a9a:	8082                	ret
  n = 0;
     a9c:	4501                	li	a0,0
     a9e:	bfe5                	j	a96 <atoi+0x3e>

0000000000000aa0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     aa0:	1141                	addi	sp,sp,-16
     aa2:	e422                	sd	s0,8(sp)
     aa4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     aa6:	02b57463          	bgeu	a0,a1,ace <memmove+0x2e>
    while(n-- > 0)
     aaa:	00c05f63          	blez	a2,ac8 <memmove+0x28>
     aae:	1602                	slli	a2,a2,0x20
     ab0:	9201                	srli	a2,a2,0x20
     ab2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     ab6:	872a                	mv	a4,a0
      *dst++ = *src++;
     ab8:	0585                	addi	a1,a1,1
     aba:	0705                	addi	a4,a4,1
     abc:	fff5c683          	lbu	a3,-1(a1)
     ac0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     ac4:	fef71ae3          	bne	a4,a5,ab8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ac8:	6422                	ld	s0,8(sp)
     aca:	0141                	addi	sp,sp,16
     acc:	8082                	ret
    dst += n;
     ace:	00c50733          	add	a4,a0,a2
    src += n;
     ad2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     ad4:	fec05ae3          	blez	a2,ac8 <memmove+0x28>
     ad8:	fff6079b          	addiw	a5,a2,-1
     adc:	1782                	slli	a5,a5,0x20
     ade:	9381                	srli	a5,a5,0x20
     ae0:	fff7c793          	not	a5,a5
     ae4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ae6:	15fd                	addi	a1,a1,-1
     ae8:	177d                	addi	a4,a4,-1
     aea:	0005c683          	lbu	a3,0(a1)
     aee:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     af2:	fee79ae3          	bne	a5,a4,ae6 <memmove+0x46>
     af6:	bfc9                	j	ac8 <memmove+0x28>

0000000000000af8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     af8:	1141                	addi	sp,sp,-16
     afa:	e422                	sd	s0,8(sp)
     afc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     afe:	ca05                	beqz	a2,b2e <memcmp+0x36>
     b00:	fff6069b          	addiw	a3,a2,-1
     b04:	1682                	slli	a3,a3,0x20
     b06:	9281                	srli	a3,a3,0x20
     b08:	0685                	addi	a3,a3,1
     b0a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     b0c:	00054783          	lbu	a5,0(a0)
     b10:	0005c703          	lbu	a4,0(a1)
     b14:	00e79863          	bne	a5,a4,b24 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     b18:	0505                	addi	a0,a0,1
    p2++;
     b1a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     b1c:	fed518e3          	bne	a0,a3,b0c <memcmp+0x14>
  }
  return 0;
     b20:	4501                	li	a0,0
     b22:	a019                	j	b28 <memcmp+0x30>
      return *p1 - *p2;
     b24:	40e7853b          	subw	a0,a5,a4
}
     b28:	6422                	ld	s0,8(sp)
     b2a:	0141                	addi	sp,sp,16
     b2c:	8082                	ret
  return 0;
     b2e:	4501                	li	a0,0
     b30:	bfe5                	j	b28 <memcmp+0x30>

0000000000000b32 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b32:	1141                	addi	sp,sp,-16
     b34:	e406                	sd	ra,8(sp)
     b36:	e022                	sd	s0,0(sp)
     b38:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     b3a:	f67ff0ef          	jal	aa0 <memmove>
}
     b3e:	60a2                	ld	ra,8(sp)
     b40:	6402                	ld	s0,0(sp)
     b42:	0141                	addi	sp,sp,16
     b44:	8082                	ret

0000000000000b46 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     b46:	4885                	li	a7,1
 ecall
     b48:	00000073          	ecall
 ret
     b4c:	8082                	ret

0000000000000b4e <exit>:
.global exit
exit:
 li a7, SYS_exit
     b4e:	4889                	li	a7,2
 ecall
     b50:	00000073          	ecall
 ret
     b54:	8082                	ret

0000000000000b56 <wait>:
.global wait
wait:
 li a7, SYS_wait
     b56:	488d                	li	a7,3
 ecall
     b58:	00000073          	ecall
 ret
     b5c:	8082                	ret

0000000000000b5e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     b5e:	4891                	li	a7,4
 ecall
     b60:	00000073          	ecall
 ret
     b64:	8082                	ret

0000000000000b66 <read>:
.global read
read:
 li a7, SYS_read
     b66:	4895                	li	a7,5
 ecall
     b68:	00000073          	ecall
 ret
     b6c:	8082                	ret

0000000000000b6e <write>:
.global write
write:
 li a7, SYS_write
     b6e:	48c1                	li	a7,16
 ecall
     b70:	00000073          	ecall
 ret
     b74:	8082                	ret

0000000000000b76 <close>:
.global close
close:
 li a7, SYS_close
     b76:	48d5                	li	a7,21
 ecall
     b78:	00000073          	ecall
 ret
     b7c:	8082                	ret

0000000000000b7e <kill>:
.global kill
kill:
 li a7, SYS_kill
     b7e:	4899                	li	a7,6
 ecall
     b80:	00000073          	ecall
 ret
     b84:	8082                	ret

0000000000000b86 <exec>:
.global exec
exec:
 li a7, SYS_exec
     b86:	489d                	li	a7,7
 ecall
     b88:	00000073          	ecall
 ret
     b8c:	8082                	ret

0000000000000b8e <open>:
.global open
open:
 li a7, SYS_open
     b8e:	48bd                	li	a7,15
 ecall
     b90:	00000073          	ecall
 ret
     b94:	8082                	ret

0000000000000b96 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     b96:	48c5                	li	a7,17
 ecall
     b98:	00000073          	ecall
 ret
     b9c:	8082                	ret

0000000000000b9e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     b9e:	48c9                	li	a7,18
 ecall
     ba0:	00000073          	ecall
 ret
     ba4:	8082                	ret

0000000000000ba6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     ba6:	48a1                	li	a7,8
 ecall
     ba8:	00000073          	ecall
 ret
     bac:	8082                	ret

0000000000000bae <link>:
.global link
link:
 li a7, SYS_link
     bae:	48cd                	li	a7,19
 ecall
     bb0:	00000073          	ecall
 ret
     bb4:	8082                	ret

0000000000000bb6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     bb6:	48d1                	li	a7,20
 ecall
     bb8:	00000073          	ecall
 ret
     bbc:	8082                	ret

0000000000000bbe <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     bbe:	48a5                	li	a7,9
 ecall
     bc0:	00000073          	ecall
 ret
     bc4:	8082                	ret

0000000000000bc6 <dup>:
.global dup
dup:
 li a7, SYS_dup
     bc6:	48a9                	li	a7,10
 ecall
     bc8:	00000073          	ecall
 ret
     bcc:	8082                	ret

0000000000000bce <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     bce:	48ad                	li	a7,11
 ecall
     bd0:	00000073          	ecall
 ret
     bd4:	8082                	ret

0000000000000bd6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     bd6:	48b1                	li	a7,12
 ecall
     bd8:	00000073          	ecall
 ret
     bdc:	8082                	ret

0000000000000bde <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     bde:	48b5                	li	a7,13
 ecall
     be0:	00000073          	ecall
 ret
     be4:	8082                	ret

0000000000000be6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     be6:	48b9                	li	a7,14
 ecall
     be8:	00000073          	ecall
 ret
     bec:	8082                	ret

0000000000000bee <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     bee:	1101                	addi	sp,sp,-32
     bf0:	ec06                	sd	ra,24(sp)
     bf2:	e822                	sd	s0,16(sp)
     bf4:	1000                	addi	s0,sp,32
     bf6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     bfa:	4605                	li	a2,1
     bfc:	fef40593          	addi	a1,s0,-17
     c00:	f6fff0ef          	jal	b6e <write>
}
     c04:	60e2                	ld	ra,24(sp)
     c06:	6442                	ld	s0,16(sp)
     c08:	6105                	addi	sp,sp,32
     c0a:	8082                	ret

0000000000000c0c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     c0c:	7139                	addi	sp,sp,-64
     c0e:	fc06                	sd	ra,56(sp)
     c10:	f822                	sd	s0,48(sp)
     c12:	f426                	sd	s1,40(sp)
     c14:	0080                	addi	s0,sp,64
     c16:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     c18:	c299                	beqz	a3,c1e <printint+0x12>
     c1a:	0805c963          	bltz	a1,cac <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     c1e:	2581                	sext.w	a1,a1
  neg = 0;
     c20:	4881                	li	a7,0
     c22:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     c26:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     c28:	2601                	sext.w	a2,a2
     c2a:	00001517          	auipc	a0,0x1
     c2e:	86650513          	addi	a0,a0,-1946 # 1490 <digits>
     c32:	883a                	mv	a6,a4
     c34:	2705                	addiw	a4,a4,1
     c36:	02c5f7bb          	remuw	a5,a1,a2
     c3a:	1782                	slli	a5,a5,0x20
     c3c:	9381                	srli	a5,a5,0x20
     c3e:	97aa                	add	a5,a5,a0
     c40:	0007c783          	lbu	a5,0(a5)
     c44:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     c48:	0005879b          	sext.w	a5,a1
     c4c:	02c5d5bb          	divuw	a1,a1,a2
     c50:	0685                	addi	a3,a3,1
     c52:	fec7f0e3          	bgeu	a5,a2,c32 <printint+0x26>
  if(neg)
     c56:	00088c63          	beqz	a7,c6e <printint+0x62>
    buf[i++] = '-';
     c5a:	fd070793          	addi	a5,a4,-48
     c5e:	00878733          	add	a4,a5,s0
     c62:	02d00793          	li	a5,45
     c66:	fef70823          	sb	a5,-16(a4)
     c6a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     c6e:	02e05a63          	blez	a4,ca2 <printint+0x96>
     c72:	f04a                	sd	s2,32(sp)
     c74:	ec4e                	sd	s3,24(sp)
     c76:	fc040793          	addi	a5,s0,-64
     c7a:	00e78933          	add	s2,a5,a4
     c7e:	fff78993          	addi	s3,a5,-1
     c82:	99ba                	add	s3,s3,a4
     c84:	377d                	addiw	a4,a4,-1
     c86:	1702                	slli	a4,a4,0x20
     c88:	9301                	srli	a4,a4,0x20
     c8a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     c8e:	fff94583          	lbu	a1,-1(s2)
     c92:	8526                	mv	a0,s1
     c94:	f5bff0ef          	jal	bee <putc>
  while(--i >= 0)
     c98:	197d                	addi	s2,s2,-1
     c9a:	ff391ae3          	bne	s2,s3,c8e <printint+0x82>
     c9e:	7902                	ld	s2,32(sp)
     ca0:	69e2                	ld	s3,24(sp)
}
     ca2:	70e2                	ld	ra,56(sp)
     ca4:	7442                	ld	s0,48(sp)
     ca6:	74a2                	ld	s1,40(sp)
     ca8:	6121                	addi	sp,sp,64
     caa:	8082                	ret
    x = -xx;
     cac:	40b005bb          	negw	a1,a1
    neg = 1;
     cb0:	4885                	li	a7,1
    x = -xx;
     cb2:	bf85                	j	c22 <printint+0x16>

0000000000000cb4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     cb4:	711d                	addi	sp,sp,-96
     cb6:	ec86                	sd	ra,88(sp)
     cb8:	e8a2                	sd	s0,80(sp)
     cba:	e0ca                	sd	s2,64(sp)
     cbc:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     cbe:	0005c903          	lbu	s2,0(a1)
     cc2:	26090863          	beqz	s2,f32 <vprintf+0x27e>
     cc6:	e4a6                	sd	s1,72(sp)
     cc8:	fc4e                	sd	s3,56(sp)
     cca:	f852                	sd	s4,48(sp)
     ccc:	f456                	sd	s5,40(sp)
     cce:	f05a                	sd	s6,32(sp)
     cd0:	ec5e                	sd	s7,24(sp)
     cd2:	e862                	sd	s8,16(sp)
     cd4:	e466                	sd	s9,8(sp)
     cd6:	8b2a                	mv	s6,a0
     cd8:	8a2e                	mv	s4,a1
     cda:	8bb2                	mv	s7,a2
  state = 0;
     cdc:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     cde:	4481                	li	s1,0
     ce0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     ce2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     ce6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     cea:	06c00c93          	li	s9,108
     cee:	a005                	j	d0e <vprintf+0x5a>
        putc(fd, c0);
     cf0:	85ca                	mv	a1,s2
     cf2:	855a                	mv	a0,s6
     cf4:	efbff0ef          	jal	bee <putc>
     cf8:	a019                	j	cfe <vprintf+0x4a>
    } else if(state == '%'){
     cfa:	03598263          	beq	s3,s5,d1e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     cfe:	2485                	addiw	s1,s1,1
     d00:	8726                	mv	a4,s1
     d02:	009a07b3          	add	a5,s4,s1
     d06:	0007c903          	lbu	s2,0(a5)
     d0a:	20090c63          	beqz	s2,f22 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
     d0e:	0009079b          	sext.w	a5,s2
    if(state == 0){
     d12:	fe0994e3          	bnez	s3,cfa <vprintf+0x46>
      if(c0 == '%'){
     d16:	fd579de3          	bne	a5,s5,cf0 <vprintf+0x3c>
        state = '%';
     d1a:	89be                	mv	s3,a5
     d1c:	b7cd                	j	cfe <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     d1e:	00ea06b3          	add	a3,s4,a4
     d22:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     d26:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     d28:	c681                	beqz	a3,d30 <vprintf+0x7c>
     d2a:	9752                	add	a4,a4,s4
     d2c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     d30:	03878f63          	beq	a5,s8,d6e <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
     d34:	05978963          	beq	a5,s9,d86 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     d38:	07500713          	li	a4,117
     d3c:	0ee78363          	beq	a5,a4,e22 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     d40:	07800713          	li	a4,120
     d44:	12e78563          	beq	a5,a4,e6e <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     d48:	07000713          	li	a4,112
     d4c:	14e78a63          	beq	a5,a4,ea0 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
     d50:	07300713          	li	a4,115
     d54:	18e78a63          	beq	a5,a4,ee8 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     d58:	02500713          	li	a4,37
     d5c:	04e79563          	bne	a5,a4,da6 <vprintf+0xf2>
        putc(fd, '%');
     d60:	02500593          	li	a1,37
     d64:	855a                	mv	a0,s6
     d66:	e89ff0ef          	jal	bee <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
     d6a:	4981                	li	s3,0
     d6c:	bf49                	j	cfe <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     d6e:	008b8913          	addi	s2,s7,8
     d72:	4685                	li	a3,1
     d74:	4629                	li	a2,10
     d76:	000ba583          	lw	a1,0(s7)
     d7a:	855a                	mv	a0,s6
     d7c:	e91ff0ef          	jal	c0c <printint>
     d80:	8bca                	mv	s7,s2
      state = 0;
     d82:	4981                	li	s3,0
     d84:	bfad                	j	cfe <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     d86:	06400793          	li	a5,100
     d8a:	02f68963          	beq	a3,a5,dbc <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     d8e:	06c00793          	li	a5,108
     d92:	04f68263          	beq	a3,a5,dd6 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
     d96:	07500793          	li	a5,117
     d9a:	0af68063          	beq	a3,a5,e3a <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
     d9e:	07800793          	li	a5,120
     da2:	0ef68263          	beq	a3,a5,e86 <vprintf+0x1d2>
        putc(fd, '%');
     da6:	02500593          	li	a1,37
     daa:	855a                	mv	a0,s6
     dac:	e43ff0ef          	jal	bee <putc>
        putc(fd, c0);
     db0:	85ca                	mv	a1,s2
     db2:	855a                	mv	a0,s6
     db4:	e3bff0ef          	jal	bee <putc>
      state = 0;
     db8:	4981                	li	s3,0
     dba:	b791                	j	cfe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     dbc:	008b8913          	addi	s2,s7,8
     dc0:	4685                	li	a3,1
     dc2:	4629                	li	a2,10
     dc4:	000ba583          	lw	a1,0(s7)
     dc8:	855a                	mv	a0,s6
     dca:	e43ff0ef          	jal	c0c <printint>
        i += 1;
     dce:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     dd0:	8bca                	mv	s7,s2
      state = 0;
     dd2:	4981                	li	s3,0
        i += 1;
     dd4:	b72d                	j	cfe <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     dd6:	06400793          	li	a5,100
     dda:	02f60763          	beq	a2,a5,e08 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     dde:	07500793          	li	a5,117
     de2:	06f60963          	beq	a2,a5,e54 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     de6:	07800793          	li	a5,120
     dea:	faf61ee3          	bne	a2,a5,da6 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
     dee:	008b8913          	addi	s2,s7,8
     df2:	4681                	li	a3,0
     df4:	4641                	li	a2,16
     df6:	000ba583          	lw	a1,0(s7)
     dfa:	855a                	mv	a0,s6
     dfc:	e11ff0ef          	jal	c0c <printint>
        i += 2;
     e00:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     e02:	8bca                	mv	s7,s2
      state = 0;
     e04:	4981                	li	s3,0
        i += 2;
     e06:	bde5                	j	cfe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e08:	008b8913          	addi	s2,s7,8
     e0c:	4685                	li	a3,1
     e0e:	4629                	li	a2,10
     e10:	000ba583          	lw	a1,0(s7)
     e14:	855a                	mv	a0,s6
     e16:	df7ff0ef          	jal	c0c <printint>
        i += 2;
     e1a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     e1c:	8bca                	mv	s7,s2
      state = 0;
     e1e:	4981                	li	s3,0
        i += 2;
     e20:	bdf9                	j	cfe <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
     e22:	008b8913          	addi	s2,s7,8
     e26:	4681                	li	a3,0
     e28:	4629                	li	a2,10
     e2a:	000ba583          	lw	a1,0(s7)
     e2e:	855a                	mv	a0,s6
     e30:	dddff0ef          	jal	c0c <printint>
     e34:	8bca                	mv	s7,s2
      state = 0;
     e36:	4981                	li	s3,0
     e38:	b5d9                	j	cfe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e3a:	008b8913          	addi	s2,s7,8
     e3e:	4681                	li	a3,0
     e40:	4629                	li	a2,10
     e42:	000ba583          	lw	a1,0(s7)
     e46:	855a                	mv	a0,s6
     e48:	dc5ff0ef          	jal	c0c <printint>
        i += 1;
     e4c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     e4e:	8bca                	mv	s7,s2
      state = 0;
     e50:	4981                	li	s3,0
        i += 1;
     e52:	b575                	j	cfe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e54:	008b8913          	addi	s2,s7,8
     e58:	4681                	li	a3,0
     e5a:	4629                	li	a2,10
     e5c:	000ba583          	lw	a1,0(s7)
     e60:	855a                	mv	a0,s6
     e62:	dabff0ef          	jal	c0c <printint>
        i += 2;
     e66:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     e68:	8bca                	mv	s7,s2
      state = 0;
     e6a:	4981                	li	s3,0
        i += 2;
     e6c:	bd49                	j	cfe <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
     e6e:	008b8913          	addi	s2,s7,8
     e72:	4681                	li	a3,0
     e74:	4641                	li	a2,16
     e76:	000ba583          	lw	a1,0(s7)
     e7a:	855a                	mv	a0,s6
     e7c:	d91ff0ef          	jal	c0c <printint>
     e80:	8bca                	mv	s7,s2
      state = 0;
     e82:	4981                	li	s3,0
     e84:	bdad                	j	cfe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
     e86:	008b8913          	addi	s2,s7,8
     e8a:	4681                	li	a3,0
     e8c:	4641                	li	a2,16
     e8e:	000ba583          	lw	a1,0(s7)
     e92:	855a                	mv	a0,s6
     e94:	d79ff0ef          	jal	c0c <printint>
        i += 1;
     e98:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     e9a:	8bca                	mv	s7,s2
      state = 0;
     e9c:	4981                	li	s3,0
        i += 1;
     e9e:	b585                	j	cfe <vprintf+0x4a>
     ea0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
     ea2:	008b8d13          	addi	s10,s7,8
     ea6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     eaa:	03000593          	li	a1,48
     eae:	855a                	mv	a0,s6
     eb0:	d3fff0ef          	jal	bee <putc>
  putc(fd, 'x');
     eb4:	07800593          	li	a1,120
     eb8:	855a                	mv	a0,s6
     eba:	d35ff0ef          	jal	bee <putc>
     ebe:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ec0:	00000b97          	auipc	s7,0x0
     ec4:	5d0b8b93          	addi	s7,s7,1488 # 1490 <digits>
     ec8:	03c9d793          	srli	a5,s3,0x3c
     ecc:	97de                	add	a5,a5,s7
     ece:	0007c583          	lbu	a1,0(a5)
     ed2:	855a                	mv	a0,s6
     ed4:	d1bff0ef          	jal	bee <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     ed8:	0992                	slli	s3,s3,0x4
     eda:	397d                	addiw	s2,s2,-1
     edc:	fe0916e3          	bnez	s2,ec8 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
     ee0:	8bea                	mv	s7,s10
      state = 0;
     ee2:	4981                	li	s3,0
     ee4:	6d02                	ld	s10,0(sp)
     ee6:	bd21                	j	cfe <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
     ee8:	008b8993          	addi	s3,s7,8
     eec:	000bb903          	ld	s2,0(s7)
     ef0:	00090f63          	beqz	s2,f0e <vprintf+0x25a>
        for(; *s; s++)
     ef4:	00094583          	lbu	a1,0(s2)
     ef8:	c195                	beqz	a1,f1c <vprintf+0x268>
          putc(fd, *s);
     efa:	855a                	mv	a0,s6
     efc:	cf3ff0ef          	jal	bee <putc>
        for(; *s; s++)
     f00:	0905                	addi	s2,s2,1
     f02:	00094583          	lbu	a1,0(s2)
     f06:	f9f5                	bnez	a1,efa <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     f08:	8bce                	mv	s7,s3
      state = 0;
     f0a:	4981                	li	s3,0
     f0c:	bbcd                	j	cfe <vprintf+0x4a>
          s = "(null)";
     f0e:	00000917          	auipc	s2,0x0
     f12:	51a90913          	addi	s2,s2,1306 # 1428 <malloc+0x40e>
        for(; *s; s++)
     f16:	02800593          	li	a1,40
     f1a:	b7c5                	j	efa <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     f1c:	8bce                	mv	s7,s3
      state = 0;
     f1e:	4981                	li	s3,0
     f20:	bbf9                	j	cfe <vprintf+0x4a>
     f22:	64a6                	ld	s1,72(sp)
     f24:	79e2                	ld	s3,56(sp)
     f26:	7a42                	ld	s4,48(sp)
     f28:	7aa2                	ld	s5,40(sp)
     f2a:	7b02                	ld	s6,32(sp)
     f2c:	6be2                	ld	s7,24(sp)
     f2e:	6c42                	ld	s8,16(sp)
     f30:	6ca2                	ld	s9,8(sp)
    }
  }
}
     f32:	60e6                	ld	ra,88(sp)
     f34:	6446                	ld	s0,80(sp)
     f36:	6906                	ld	s2,64(sp)
     f38:	6125                	addi	sp,sp,96
     f3a:	8082                	ret

0000000000000f3c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     f3c:	715d                	addi	sp,sp,-80
     f3e:	ec06                	sd	ra,24(sp)
     f40:	e822                	sd	s0,16(sp)
     f42:	1000                	addi	s0,sp,32
     f44:	e010                	sd	a2,0(s0)
     f46:	e414                	sd	a3,8(s0)
     f48:	e818                	sd	a4,16(s0)
     f4a:	ec1c                	sd	a5,24(s0)
     f4c:	03043023          	sd	a6,32(s0)
     f50:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
     f54:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     f58:	8622                	mv	a2,s0
     f5a:	d5bff0ef          	jal	cb4 <vprintf>
}
     f5e:	60e2                	ld	ra,24(sp)
     f60:	6442                	ld	s0,16(sp)
     f62:	6161                	addi	sp,sp,80
     f64:	8082                	ret

0000000000000f66 <printf>:

void
printf(const char *fmt, ...)
{
     f66:	711d                	addi	sp,sp,-96
     f68:	ec06                	sd	ra,24(sp)
     f6a:	e822                	sd	s0,16(sp)
     f6c:	1000                	addi	s0,sp,32
     f6e:	e40c                	sd	a1,8(s0)
     f70:	e810                	sd	a2,16(s0)
     f72:	ec14                	sd	a3,24(s0)
     f74:	f018                	sd	a4,32(s0)
     f76:	f41c                	sd	a5,40(s0)
     f78:	03043823          	sd	a6,48(s0)
     f7c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     f80:	00840613          	addi	a2,s0,8
     f84:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
     f88:	85aa                	mv	a1,a0
     f8a:	4505                	li	a0,1
     f8c:	d29ff0ef          	jal	cb4 <vprintf>
}
     f90:	60e2                	ld	ra,24(sp)
     f92:	6442                	ld	s0,16(sp)
     f94:	6125                	addi	sp,sp,96
     f96:	8082                	ret

0000000000000f98 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f98:	1141                	addi	sp,sp,-16
     f9a:	e422                	sd	s0,8(sp)
     f9c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
     f9e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fa2:	00001797          	auipc	a5,0x1
     fa6:	06e7b783          	ld	a5,110(a5) # 2010 <freep>
     faa:	a02d                	j	fd4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
     fac:	4618                	lw	a4,8(a2)
     fae:	9f2d                	addw	a4,a4,a1
     fb0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
     fb4:	6398                	ld	a4,0(a5)
     fb6:	6310                	ld	a2,0(a4)
     fb8:	a83d                	j	ff6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
     fba:	ff852703          	lw	a4,-8(a0)
     fbe:	9f31                	addw	a4,a4,a2
     fc0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     fc2:	ff053683          	ld	a3,-16(a0)
     fc6:	a091                	j	100a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fc8:	6398                	ld	a4,0(a5)
     fca:	00e7e463          	bltu	a5,a4,fd2 <free+0x3a>
     fce:	00e6ea63          	bltu	a3,a4,fe2 <free+0x4a>
{
     fd2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fd4:	fed7fae3          	bgeu	a5,a3,fc8 <free+0x30>
     fd8:	6398                	ld	a4,0(a5)
     fda:	00e6e463          	bltu	a3,a4,fe2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fde:	fee7eae3          	bltu	a5,a4,fd2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
     fe2:	ff852583          	lw	a1,-8(a0)
     fe6:	6390                	ld	a2,0(a5)
     fe8:	02059813          	slli	a6,a1,0x20
     fec:	01c85713          	srli	a4,a6,0x1c
     ff0:	9736                	add	a4,a4,a3
     ff2:	fae60de3          	beq	a2,a4,fac <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
     ff6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
     ffa:	4790                	lw	a2,8(a5)
     ffc:	02061593          	slli	a1,a2,0x20
    1000:	01c5d713          	srli	a4,a1,0x1c
    1004:	973e                	add	a4,a4,a5
    1006:	fae68ae3          	beq	a3,a4,fba <free+0x22>
    p->s.ptr = bp->s.ptr;
    100a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    100c:	00001717          	auipc	a4,0x1
    1010:	00f73223          	sd	a5,4(a4) # 2010 <freep>
}
    1014:	6422                	ld	s0,8(sp)
    1016:	0141                	addi	sp,sp,16
    1018:	8082                	ret

000000000000101a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    101a:	7139                	addi	sp,sp,-64
    101c:	fc06                	sd	ra,56(sp)
    101e:	f822                	sd	s0,48(sp)
    1020:	f426                	sd	s1,40(sp)
    1022:	ec4e                	sd	s3,24(sp)
    1024:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1026:	02051493          	slli	s1,a0,0x20
    102a:	9081                	srli	s1,s1,0x20
    102c:	04bd                	addi	s1,s1,15
    102e:	8091                	srli	s1,s1,0x4
    1030:	0014899b          	addiw	s3,s1,1
    1034:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1036:	00001517          	auipc	a0,0x1
    103a:	fda53503          	ld	a0,-38(a0) # 2010 <freep>
    103e:	c915                	beqz	a0,1072 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1040:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1042:	4798                	lw	a4,8(a5)
    1044:	08977a63          	bgeu	a4,s1,10d8 <malloc+0xbe>
    1048:	f04a                	sd	s2,32(sp)
    104a:	e852                	sd	s4,16(sp)
    104c:	e456                	sd	s5,8(sp)
    104e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1050:	8a4e                	mv	s4,s3
    1052:	0009871b          	sext.w	a4,s3
    1056:	6685                	lui	a3,0x1
    1058:	00d77363          	bgeu	a4,a3,105e <malloc+0x44>
    105c:	6a05                	lui	s4,0x1
    105e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1062:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1066:	00001917          	auipc	s2,0x1
    106a:	faa90913          	addi	s2,s2,-86 # 2010 <freep>
  if(p == (char*)-1)
    106e:	5afd                	li	s5,-1
    1070:	a081                	j	10b0 <malloc+0x96>
    1072:	f04a                	sd	s2,32(sp)
    1074:	e852                	sd	s4,16(sp)
    1076:	e456                	sd	s5,8(sp)
    1078:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    107a:	00001797          	auipc	a5,0x1
    107e:	38e78793          	addi	a5,a5,910 # 2408 <base>
    1082:	00001717          	auipc	a4,0x1
    1086:	f8f73723          	sd	a5,-114(a4) # 2010 <freep>
    108a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    108c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1090:	b7c1                	j	1050 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1092:	6398                	ld	a4,0(a5)
    1094:	e118                	sd	a4,0(a0)
    1096:	a8a9                	j	10f0 <malloc+0xd6>
  hp->s.size = nu;
    1098:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    109c:	0541                	addi	a0,a0,16
    109e:	efbff0ef          	jal	f98 <free>
  return freep;
    10a2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    10a6:	c12d                	beqz	a0,1108 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    10aa:	4798                	lw	a4,8(a5)
    10ac:	02977263          	bgeu	a4,s1,10d0 <malloc+0xb6>
    if(p == freep)
    10b0:	00093703          	ld	a4,0(s2)
    10b4:	853e                	mv	a0,a5
    10b6:	fef719e3          	bne	a4,a5,10a8 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    10ba:	8552                	mv	a0,s4
    10bc:	b1bff0ef          	jal	bd6 <sbrk>
  if(p == (char*)-1)
    10c0:	fd551ce3          	bne	a0,s5,1098 <malloc+0x7e>
        return 0;
    10c4:	4501                	li	a0,0
    10c6:	7902                	ld	s2,32(sp)
    10c8:	6a42                	ld	s4,16(sp)
    10ca:	6aa2                	ld	s5,8(sp)
    10cc:	6b02                	ld	s6,0(sp)
    10ce:	a03d                	j	10fc <malloc+0xe2>
    10d0:	7902                	ld	s2,32(sp)
    10d2:	6a42                	ld	s4,16(sp)
    10d4:	6aa2                	ld	s5,8(sp)
    10d6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    10d8:	fae48de3          	beq	s1,a4,1092 <malloc+0x78>
        p->s.size -= nunits;
    10dc:	4137073b          	subw	a4,a4,s3
    10e0:	c798                	sw	a4,8(a5)
        p += p->s.size;
    10e2:	02071693          	slli	a3,a4,0x20
    10e6:	01c6d713          	srli	a4,a3,0x1c
    10ea:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    10ec:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    10f0:	00001717          	auipc	a4,0x1
    10f4:	f2a73023          	sd	a0,-224(a4) # 2010 <freep>
      return (void*)(p + 1);
    10f8:	01078513          	addi	a0,a5,16
  }
}
    10fc:	70e2                	ld	ra,56(sp)
    10fe:	7442                	ld	s0,48(sp)
    1100:	74a2                	ld	s1,40(sp)
    1102:	69e2                	ld	s3,24(sp)
    1104:	6121                	addi	sp,sp,64
    1106:	8082                	ret
    1108:	7902                	ld	s2,32(sp)
    110a:	6a42                	ld	s4,16(sp)
    110c:	6aa2                	ld	s5,8(sp)
    110e:	6b02                	ld	s6,0(sp)
    1110:	b7f5                	j	10fc <malloc+0xe2>
