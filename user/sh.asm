
user/_sh：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	1ae58593          	addi	a1,a1,430 # 11c0 <malloc+0xf8>
      1a:	4509                	li	a0,2
      1c:	401000ef          	jal	c1c <write>
  memset(buf, 0, nbuf);
      20:	864a                	mv	a2,s2
      22:	4581                	li	a1,0
      24:	8526                	mv	a0,s1
      26:	1f1000ef          	jal	a16 <memset>
  gets(buf, nbuf);
      2a:	85ca                	mv	a1,s2
      2c:	8526                	mv	a0,s1
      2e:	22f000ef          	jal	a5c <gets>
  if(buf[0] == 0) // EOF
      32:	0004c503          	lbu	a0,0(s1)
      36:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      3a:	40a00533          	neg	a0,a0
      3e:	60e2                	ld	ra,24(sp)
      40:	6442                	ld	s0,16(sp)
      42:	64a2                	ld	s1,8(sp)
      44:	6902                	ld	s2,0(sp)
      46:	6105                	addi	sp,sp,32
      48:	8082                	ret

000000000000004a <panic>:
  exit(0);
}

void
panic(char *s)
{
      4a:	1141                	addi	sp,sp,-16
      4c:	e406                	sd	ra,8(sp)
      4e:	e022                	sd	s0,0(sp)
      50:	0800                	addi	s0,sp,16
      52:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      54:	00001597          	auipc	a1,0x1
      58:	17c58593          	addi	a1,a1,380 # 11d0 <malloc+0x108>
      5c:	4509                	li	a0,2
      5e:	78d000ef          	jal	fea <fprintf>
  exit(1);
      62:	4505                	li	a0,1
      64:	399000ef          	jal	bfc <exit>

0000000000000068 <fork1>:
}

int
fork1(void)
{
      68:	1141                	addi	sp,sp,-16
      6a:	e406                	sd	ra,8(sp)
      6c:	e022                	sd	s0,0(sp)
      6e:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      70:	385000ef          	jal	bf4 <fork>
  if(pid == -1)
      74:	57fd                	li	a5,-1
      76:	00f50663          	beq	a0,a5,82 <fork1+0x1a>
    panic("fork");
  return pid;
}
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
    panic("fork");
      82:	00001517          	auipc	a0,0x1
      86:	15650513          	addi	a0,a0,342 # 11d8 <malloc+0x110>
      8a:	fc1ff0ef          	jal	4a <panic>

000000000000008e <runcmd>:
{
      8e:	7179                	addi	sp,sp,-48
      90:	f406                	sd	ra,40(sp)
      92:	f022                	sd	s0,32(sp)
      94:	1800                	addi	s0,sp,48
  if(cmd == 0)
      96:	c115                	beqz	a0,ba <runcmd+0x2c>
      98:	ec26                	sd	s1,24(sp)
      9a:	84aa                	mv	s1,a0
  switch(cmd->type){
      9c:	4118                	lw	a4,0(a0)
      9e:	4795                	li	a5,5
      a0:	02e7e163          	bltu	a5,a4,c2 <runcmd+0x34>
      a4:	00056783          	lwu	a5,0(a0)
      a8:	078a                	slli	a5,a5,0x2
      aa:	00001717          	auipc	a4,0x1
      ae:	22e70713          	addi	a4,a4,558 # 12d8 <malloc+0x210>
      b2:	97ba                	add	a5,a5,a4
      b4:	439c                	lw	a5,0(a5)
      b6:	97ba                	add	a5,a5,a4
      b8:	8782                	jr	a5
      ba:	ec26                	sd	s1,24(sp)
    exit(1);
      bc:	4505                	li	a0,1
      be:	33f000ef          	jal	bfc <exit>
    panic("runcmd");
      c2:	00001517          	auipc	a0,0x1
      c6:	11e50513          	addi	a0,a0,286 # 11e0 <malloc+0x118>
      ca:	f81ff0ef          	jal	4a <panic>
    if(ecmd->argv[0] == 0)
      ce:	6508                	ld	a0,8(a0)
      d0:	c105                	beqz	a0,f0 <runcmd+0x62>
    exec(ecmd->argv[0], ecmd->argv);
      d2:	00848593          	addi	a1,s1,8
      d6:	35f000ef          	jal	c34 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      da:	6490                	ld	a2,8(s1)
      dc:	00001597          	auipc	a1,0x1
      e0:	10c58593          	addi	a1,a1,268 # 11e8 <malloc+0x120>
      e4:	4509                	li	a0,2
      e6:	705000ef          	jal	fea <fprintf>
  exit(0);
      ea:	4501                	li	a0,0
      ec:	311000ef          	jal	bfc <exit>
      exit(1);
      f0:	4505                	li	a0,1
      f2:	30b000ef          	jal	bfc <exit>
    close(rcmd->fd);
      f6:	5148                	lw	a0,36(a0)
      f8:	32d000ef          	jal	c24 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      fc:	508c                	lw	a1,32(s1)
      fe:	6888                	ld	a0,16(s1)
     100:	33d000ef          	jal	c3c <open>
     104:	00054563          	bltz	a0,10e <runcmd+0x80>
    runcmd(rcmd->cmd);
     108:	6488                	ld	a0,8(s1)
     10a:	f85ff0ef          	jal	8e <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     10e:	6890                	ld	a2,16(s1)
     110:	00001597          	auipc	a1,0x1
     114:	0e858593          	addi	a1,a1,232 # 11f8 <malloc+0x130>
     118:	4509                	li	a0,2
     11a:	6d1000ef          	jal	fea <fprintf>
      exit(1);
     11e:	4505                	li	a0,1
     120:	2dd000ef          	jal	bfc <exit>
    if(fork1() == 0)
     124:	f45ff0ef          	jal	68 <fork1>
     128:	e501                	bnez	a0,130 <runcmd+0xa2>
      runcmd(lcmd->left);
     12a:	6488                	ld	a0,8(s1)
     12c:	f63ff0ef          	jal	8e <runcmd>
    wait(0);
     130:	4501                	li	a0,0
     132:	2d3000ef          	jal	c04 <wait>
    runcmd(lcmd->right);
     136:	6888                	ld	a0,16(s1)
     138:	f57ff0ef          	jal	8e <runcmd>
    if(pipe(p) < 0)
     13c:	fd840513          	addi	a0,s0,-40
     140:	2cd000ef          	jal	c0c <pipe>
     144:	02054763          	bltz	a0,172 <runcmd+0xe4>
    if(fork1() == 0){
     148:	f21ff0ef          	jal	68 <fork1>
     14c:	e90d                	bnez	a0,17e <runcmd+0xf0>
      close(1);
     14e:	4505                	li	a0,1
     150:	2d5000ef          	jal	c24 <close>
      dup(p[1]);
     154:	fdc42503          	lw	a0,-36(s0)
     158:	31d000ef          	jal	c74 <dup>
      close(p[0]);
     15c:	fd842503          	lw	a0,-40(s0)
     160:	2c5000ef          	jal	c24 <close>
      close(p[1]);
     164:	fdc42503          	lw	a0,-36(s0)
     168:	2bd000ef          	jal	c24 <close>
      runcmd(pcmd->left);
     16c:	6488                	ld	a0,8(s1)
     16e:	f21ff0ef          	jal	8e <runcmd>
      panic("pipe");
     172:	00001517          	auipc	a0,0x1
     176:	09650513          	addi	a0,a0,150 # 1208 <malloc+0x140>
     17a:	ed1ff0ef          	jal	4a <panic>
    if(fork1() == 0){
     17e:	eebff0ef          	jal	68 <fork1>
     182:	e115                	bnez	a0,1a6 <runcmd+0x118>
      close(0);
     184:	2a1000ef          	jal	c24 <close>
      dup(p[0]);
     188:	fd842503          	lw	a0,-40(s0)
     18c:	2e9000ef          	jal	c74 <dup>
      close(p[0]);
     190:	fd842503          	lw	a0,-40(s0)
     194:	291000ef          	jal	c24 <close>
      close(p[1]);
     198:	fdc42503          	lw	a0,-36(s0)
     19c:	289000ef          	jal	c24 <close>
      runcmd(pcmd->right);
     1a0:	6888                	ld	a0,16(s1)
     1a2:	eedff0ef          	jal	8e <runcmd>
    close(p[0]);
     1a6:	fd842503          	lw	a0,-40(s0)
     1aa:	27b000ef          	jal	c24 <close>
    close(p[1]);
     1ae:	fdc42503          	lw	a0,-36(s0)
     1b2:	273000ef          	jal	c24 <close>
    wait(0);
     1b6:	4501                	li	a0,0
     1b8:	24d000ef          	jal	c04 <wait>
    wait(0);
     1bc:	4501                	li	a0,0
     1be:	247000ef          	jal	c04 <wait>
    break;
     1c2:	b725                	j	ea <runcmd+0x5c>
    if(fork1() == 0)
     1c4:	ea5ff0ef          	jal	68 <fork1>
     1c8:	f20511e3          	bnez	a0,ea <runcmd+0x5c>
      runcmd(bcmd->cmd);
     1cc:	6488                	ld	a0,8(s1)
     1ce:	ec1ff0ef          	jal	8e <runcmd>

00000000000001d2 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     1d2:	1101                	addi	sp,sp,-32
     1d4:	ec06                	sd	ra,24(sp)
     1d6:	e822                	sd	s0,16(sp)
     1d8:	e426                	sd	s1,8(sp)
     1da:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     1dc:	0a800513          	li	a0,168
     1e0:	6e9000ef          	jal	10c8 <malloc>
     1e4:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     1e6:	0a800613          	li	a2,168
     1ea:	4581                	li	a1,0
     1ec:	02b000ef          	jal	a16 <memset>
  cmd->type = EXEC;
     1f0:	4785                	li	a5,1
     1f2:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     1f4:	8526                	mv	a0,s1
     1f6:	60e2                	ld	ra,24(sp)
     1f8:	6442                	ld	s0,16(sp)
     1fa:	64a2                	ld	s1,8(sp)
     1fc:	6105                	addi	sp,sp,32
     1fe:	8082                	ret

0000000000000200 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     200:	7139                	addi	sp,sp,-64
     202:	fc06                	sd	ra,56(sp)
     204:	f822                	sd	s0,48(sp)
     206:	f426                	sd	s1,40(sp)
     208:	f04a                	sd	s2,32(sp)
     20a:	ec4e                	sd	s3,24(sp)
     20c:	e852                	sd	s4,16(sp)
     20e:	e456                	sd	s5,8(sp)
     210:	e05a                	sd	s6,0(sp)
     212:	0080                	addi	s0,sp,64
     214:	8b2a                	mv	s6,a0
     216:	8aae                	mv	s5,a1
     218:	8a32                	mv	s4,a2
     21a:	89b6                	mv	s3,a3
     21c:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     21e:	02800513          	li	a0,40
     222:	6a7000ef          	jal	10c8 <malloc>
     226:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     228:	02800613          	li	a2,40
     22c:	4581                	li	a1,0
     22e:	7e8000ef          	jal	a16 <memset>
  cmd->type = REDIR;
     232:	4789                	li	a5,2
     234:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     236:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     23a:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     23e:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     242:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     246:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     24a:	8526                	mv	a0,s1
     24c:	70e2                	ld	ra,56(sp)
     24e:	7442                	ld	s0,48(sp)
     250:	74a2                	ld	s1,40(sp)
     252:	7902                	ld	s2,32(sp)
     254:	69e2                	ld	s3,24(sp)
     256:	6a42                	ld	s4,16(sp)
     258:	6aa2                	ld	s5,8(sp)
     25a:	6b02                	ld	s6,0(sp)
     25c:	6121                	addi	sp,sp,64
     25e:	8082                	ret

0000000000000260 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     260:	7179                	addi	sp,sp,-48
     262:	f406                	sd	ra,40(sp)
     264:	f022                	sd	s0,32(sp)
     266:	ec26                	sd	s1,24(sp)
     268:	e84a                	sd	s2,16(sp)
     26a:	e44e                	sd	s3,8(sp)
     26c:	1800                	addi	s0,sp,48
     26e:	89aa                	mv	s3,a0
     270:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     272:	4561                	li	a0,24
     274:	655000ef          	jal	10c8 <malloc>
     278:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     27a:	4661                	li	a2,24
     27c:	4581                	li	a1,0
     27e:	798000ef          	jal	a16 <memset>
  cmd->type = PIPE;
     282:	478d                	li	a5,3
     284:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     286:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     28a:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     28e:	8526                	mv	a0,s1
     290:	70a2                	ld	ra,40(sp)
     292:	7402                	ld	s0,32(sp)
     294:	64e2                	ld	s1,24(sp)
     296:	6942                	ld	s2,16(sp)
     298:	69a2                	ld	s3,8(sp)
     29a:	6145                	addi	sp,sp,48
     29c:	8082                	ret

000000000000029e <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     29e:	7179                	addi	sp,sp,-48
     2a0:	f406                	sd	ra,40(sp)
     2a2:	f022                	sd	s0,32(sp)
     2a4:	ec26                	sd	s1,24(sp)
     2a6:	e84a                	sd	s2,16(sp)
     2a8:	e44e                	sd	s3,8(sp)
     2aa:	1800                	addi	s0,sp,48
     2ac:	89aa                	mv	s3,a0
     2ae:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2b0:	4561                	li	a0,24
     2b2:	617000ef          	jal	10c8 <malloc>
     2b6:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2b8:	4661                	li	a2,24
     2ba:	4581                	li	a1,0
     2bc:	75a000ef          	jal	a16 <memset>
  cmd->type = LIST;
     2c0:	4791                	li	a5,4
     2c2:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     2c4:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     2c8:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     2cc:	8526                	mv	a0,s1
     2ce:	70a2                	ld	ra,40(sp)
     2d0:	7402                	ld	s0,32(sp)
     2d2:	64e2                	ld	s1,24(sp)
     2d4:	6942                	ld	s2,16(sp)
     2d6:	69a2                	ld	s3,8(sp)
     2d8:	6145                	addi	sp,sp,48
     2da:	8082                	ret

00000000000002dc <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     2dc:	1101                	addi	sp,sp,-32
     2de:	ec06                	sd	ra,24(sp)
     2e0:	e822                	sd	s0,16(sp)
     2e2:	e426                	sd	s1,8(sp)
     2e4:	e04a                	sd	s2,0(sp)
     2e6:	1000                	addi	s0,sp,32
     2e8:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2ea:	4541                	li	a0,16
     2ec:	5dd000ef          	jal	10c8 <malloc>
     2f0:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2f2:	4641                	li	a2,16
     2f4:	4581                	li	a1,0
     2f6:	720000ef          	jal	a16 <memset>
  cmd->type = BACK;
     2fa:	4795                	li	a5,5
     2fc:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2fe:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     302:	8526                	mv	a0,s1
     304:	60e2                	ld	ra,24(sp)
     306:	6442                	ld	s0,16(sp)
     308:	64a2                	ld	s1,8(sp)
     30a:	6902                	ld	s2,0(sp)
     30c:	6105                	addi	sp,sp,32
     30e:	8082                	ret

0000000000000310 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     310:	7139                	addi	sp,sp,-64
     312:	fc06                	sd	ra,56(sp)
     314:	f822                	sd	s0,48(sp)
     316:	f426                	sd	s1,40(sp)
     318:	f04a                	sd	s2,32(sp)
     31a:	ec4e                	sd	s3,24(sp)
     31c:	e852                	sd	s4,16(sp)
     31e:	e456                	sd	s5,8(sp)
     320:	e05a                	sd	s6,0(sp)
     322:	0080                	addi	s0,sp,64
     324:	8a2a                	mv	s4,a0
     326:	892e                	mv	s2,a1
     328:	8ab2                	mv	s5,a2
     32a:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     32c:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     32e:	00002997          	auipc	s3,0x2
     332:	cda98993          	addi	s3,s3,-806 # 2008 <whitespace>
     336:	00b4fc63          	bgeu	s1,a1,34e <gettoken+0x3e>
     33a:	0004c583          	lbu	a1,0(s1)
     33e:	854e                	mv	a0,s3
     340:	6f8000ef          	jal	a38 <strchr>
     344:	c509                	beqz	a0,34e <gettoken+0x3e>
    s++;
     346:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     348:	fe9919e3          	bne	s2,s1,33a <gettoken+0x2a>
     34c:	84ca                	mv	s1,s2
  if(q)
     34e:	000a8463          	beqz	s5,356 <gettoken+0x46>
    *q = s;
     352:	009ab023          	sd	s1,0(s5)
  ret = *s;
     356:	0004c783          	lbu	a5,0(s1)
     35a:	00078a9b          	sext.w	s5,a5
  switch(*s){
     35e:	03c00713          	li	a4,60
     362:	06f76463          	bltu	a4,a5,3ca <gettoken+0xba>
     366:	03a00713          	li	a4,58
     36a:	00f76e63          	bltu	a4,a5,386 <gettoken+0x76>
     36e:	cf89                	beqz	a5,388 <gettoken+0x78>
     370:	02600713          	li	a4,38
     374:	00e78963          	beq	a5,a4,386 <gettoken+0x76>
     378:	fd87879b          	addiw	a5,a5,-40
     37c:	0ff7f793          	zext.b	a5,a5
     380:	4705                	li	a4,1
     382:	06f76b63          	bltu	a4,a5,3f8 <gettoken+0xe8>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     386:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     388:	000b0463          	beqz	s6,390 <gettoken+0x80>
    *eq = s;
     38c:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     390:	00002997          	auipc	s3,0x2
     394:	c7898993          	addi	s3,s3,-904 # 2008 <whitespace>
     398:	0124fc63          	bgeu	s1,s2,3b0 <gettoken+0xa0>
     39c:	0004c583          	lbu	a1,0(s1)
     3a0:	854e                	mv	a0,s3
     3a2:	696000ef          	jal	a38 <strchr>
     3a6:	c509                	beqz	a0,3b0 <gettoken+0xa0>
    s++;
     3a8:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     3aa:	fe9919e3          	bne	s2,s1,39c <gettoken+0x8c>
     3ae:	84ca                	mv	s1,s2
  *ps = s;
     3b0:	009a3023          	sd	s1,0(s4)
  return ret;
}
     3b4:	8556                	mv	a0,s5
     3b6:	70e2                	ld	ra,56(sp)
     3b8:	7442                	ld	s0,48(sp)
     3ba:	74a2                	ld	s1,40(sp)
     3bc:	7902                	ld	s2,32(sp)
     3be:	69e2                	ld	s3,24(sp)
     3c0:	6a42                	ld	s4,16(sp)
     3c2:	6aa2                	ld	s5,8(sp)
     3c4:	6b02                	ld	s6,0(sp)
     3c6:	6121                	addi	sp,sp,64
     3c8:	8082                	ret
  switch(*s){
     3ca:	03e00713          	li	a4,62
     3ce:	02e79163          	bne	a5,a4,3f0 <gettoken+0xe0>
    s++;
     3d2:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     3d6:	0014c703          	lbu	a4,1(s1)
     3da:	03e00793          	li	a5,62
      s++;
     3de:	0489                	addi	s1,s1,2
      ret = '+';
     3e0:	02b00a93          	li	s5,43
    if(*s == '>'){
     3e4:	faf702e3          	beq	a4,a5,388 <gettoken+0x78>
    s++;
     3e8:	84b6                	mv	s1,a3
  ret = *s;
     3ea:	03e00a93          	li	s5,62
     3ee:	bf69                	j	388 <gettoken+0x78>
  switch(*s){
     3f0:	07c00713          	li	a4,124
     3f4:	f8e789e3          	beq	a5,a4,386 <gettoken+0x76>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     3f8:	00002997          	auipc	s3,0x2
     3fc:	c1098993          	addi	s3,s3,-1008 # 2008 <whitespace>
     400:	00002a97          	auipc	s5,0x2
     404:	c00a8a93          	addi	s5,s5,-1024 # 2000 <symbols>
     408:	0324fd63          	bgeu	s1,s2,442 <gettoken+0x132>
     40c:	0004c583          	lbu	a1,0(s1)
     410:	854e                	mv	a0,s3
     412:	626000ef          	jal	a38 <strchr>
     416:	e11d                	bnez	a0,43c <gettoken+0x12c>
     418:	0004c583          	lbu	a1,0(s1)
     41c:	8556                	mv	a0,s5
     41e:	61a000ef          	jal	a38 <strchr>
     422:	e911                	bnez	a0,436 <gettoken+0x126>
      s++;
     424:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     426:	fe9913e3          	bne	s2,s1,40c <gettoken+0xfc>
  if(eq)
     42a:	84ca                	mv	s1,s2
    ret = 'a';
     42c:	06100a93          	li	s5,97
  if(eq)
     430:	f40b1ee3          	bnez	s6,38c <gettoken+0x7c>
     434:	bfb5                	j	3b0 <gettoken+0xa0>
    ret = 'a';
     436:	06100a93          	li	s5,97
     43a:	b7b9                	j	388 <gettoken+0x78>
     43c:	06100a93          	li	s5,97
     440:	b7a1                	j	388 <gettoken+0x78>
     442:	06100a93          	li	s5,97
  if(eq)
     446:	f40b13e3          	bnez	s6,38c <gettoken+0x7c>
     44a:	b79d                	j	3b0 <gettoken+0xa0>

000000000000044c <peek>:

int
peek(char **ps, char *es, char *toks)
{
     44c:	7139                	addi	sp,sp,-64
     44e:	fc06                	sd	ra,56(sp)
     450:	f822                	sd	s0,48(sp)
     452:	f426                	sd	s1,40(sp)
     454:	f04a                	sd	s2,32(sp)
     456:	ec4e                	sd	s3,24(sp)
     458:	e852                	sd	s4,16(sp)
     45a:	e456                	sd	s5,8(sp)
     45c:	0080                	addi	s0,sp,64
     45e:	8a2a                	mv	s4,a0
     460:	892e                	mv	s2,a1
     462:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     464:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     466:	00002997          	auipc	s3,0x2
     46a:	ba298993          	addi	s3,s3,-1118 # 2008 <whitespace>
     46e:	00b4fc63          	bgeu	s1,a1,486 <peek+0x3a>
     472:	0004c583          	lbu	a1,0(s1)
     476:	854e                	mv	a0,s3
     478:	5c0000ef          	jal	a38 <strchr>
     47c:	c509                	beqz	a0,486 <peek+0x3a>
    s++;
     47e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     480:	fe9919e3          	bne	s2,s1,472 <peek+0x26>
     484:	84ca                	mv	s1,s2
  *ps = s;
     486:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     48a:	0004c583          	lbu	a1,0(s1)
     48e:	4501                	li	a0,0
     490:	e991                	bnez	a1,4a4 <peek+0x58>
}
     492:	70e2                	ld	ra,56(sp)
     494:	7442                	ld	s0,48(sp)
     496:	74a2                	ld	s1,40(sp)
     498:	7902                	ld	s2,32(sp)
     49a:	69e2                	ld	s3,24(sp)
     49c:	6a42                	ld	s4,16(sp)
     49e:	6aa2                	ld	s5,8(sp)
     4a0:	6121                	addi	sp,sp,64
     4a2:	8082                	ret
  return *s && strchr(toks, *s);
     4a4:	8556                	mv	a0,s5
     4a6:	592000ef          	jal	a38 <strchr>
     4aa:	00a03533          	snez	a0,a0
     4ae:	b7d5                	j	492 <peek+0x46>

00000000000004b0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     4b0:	711d                	addi	sp,sp,-96
     4b2:	ec86                	sd	ra,88(sp)
     4b4:	e8a2                	sd	s0,80(sp)
     4b6:	e4a6                	sd	s1,72(sp)
     4b8:	e0ca                	sd	s2,64(sp)
     4ba:	fc4e                	sd	s3,56(sp)
     4bc:	f852                	sd	s4,48(sp)
     4be:	f456                	sd	s5,40(sp)
     4c0:	f05a                	sd	s6,32(sp)
     4c2:	ec5e                	sd	s7,24(sp)
     4c4:	1080                	addi	s0,sp,96
     4c6:	8a2a                	mv	s4,a0
     4c8:	89ae                	mv	s3,a1
     4ca:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     4cc:	00001a97          	auipc	s5,0x1
     4d0:	d64a8a93          	addi	s5,s5,-668 # 1230 <malloc+0x168>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     4d4:	06100b13          	li	s6,97
      panic("missing file for redirection");
    switch(tok){
     4d8:	03c00b93          	li	s7,60
  while(peek(ps, es, "<>")){
     4dc:	a00d                	j	4fe <parseredirs+0x4e>
      panic("missing file for redirection");
     4de:	00001517          	auipc	a0,0x1
     4e2:	d3250513          	addi	a0,a0,-718 # 1210 <malloc+0x148>
     4e6:	b65ff0ef          	jal	4a <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     4ea:	4701                	li	a4,0
     4ec:	4681                	li	a3,0
     4ee:	fa043603          	ld	a2,-96(s0)
     4f2:	fa843583          	ld	a1,-88(s0)
     4f6:	8552                	mv	a0,s4
     4f8:	d09ff0ef          	jal	200 <redircmd>
     4fc:	8a2a                	mv	s4,a0
  while(peek(ps, es, "<>")){
     4fe:	8656                	mv	a2,s5
     500:	85ca                	mv	a1,s2
     502:	854e                	mv	a0,s3
     504:	f49ff0ef          	jal	44c <peek>
     508:	c525                	beqz	a0,570 <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     50a:	4681                	li	a3,0
     50c:	4601                	li	a2,0
     50e:	85ca                	mv	a1,s2
     510:	854e                	mv	a0,s3
     512:	dffff0ef          	jal	310 <gettoken>
     516:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     518:	fa040693          	addi	a3,s0,-96
     51c:	fa840613          	addi	a2,s0,-88
     520:	85ca                	mv	a1,s2
     522:	854e                	mv	a0,s3
     524:	dedff0ef          	jal	310 <gettoken>
     528:	fb651be3          	bne	a0,s6,4de <parseredirs+0x2e>
    switch(tok){
     52c:	fb748fe3          	beq	s1,s7,4ea <parseredirs+0x3a>
     530:	03e00793          	li	a5,62
     534:	02f48263          	beq	s1,a5,558 <parseredirs+0xa8>
     538:	02b00793          	li	a5,43
     53c:	fcf491e3          	bne	s1,a5,4fe <parseredirs+0x4e>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     540:	4705                	li	a4,1
     542:	20100693          	li	a3,513
     546:	fa043603          	ld	a2,-96(s0)
     54a:	fa843583          	ld	a1,-88(s0)
     54e:	8552                	mv	a0,s4
     550:	cb1ff0ef          	jal	200 <redircmd>
     554:	8a2a                	mv	s4,a0
      break;
     556:	b765                	j	4fe <parseredirs+0x4e>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     558:	4705                	li	a4,1
     55a:	60100693          	li	a3,1537
     55e:	fa043603          	ld	a2,-96(s0)
     562:	fa843583          	ld	a1,-88(s0)
     566:	8552                	mv	a0,s4
     568:	c99ff0ef          	jal	200 <redircmd>
     56c:	8a2a                	mv	s4,a0
      break;
     56e:	bf41                	j	4fe <parseredirs+0x4e>
    }
  }
  return cmd;
}
     570:	8552                	mv	a0,s4
     572:	60e6                	ld	ra,88(sp)
     574:	6446                	ld	s0,80(sp)
     576:	64a6                	ld	s1,72(sp)
     578:	6906                	ld	s2,64(sp)
     57a:	79e2                	ld	s3,56(sp)
     57c:	7a42                	ld	s4,48(sp)
     57e:	7aa2                	ld	s5,40(sp)
     580:	7b02                	ld	s6,32(sp)
     582:	6be2                	ld	s7,24(sp)
     584:	6125                	addi	sp,sp,96
     586:	8082                	ret

0000000000000588 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     588:	7159                	addi	sp,sp,-112
     58a:	f486                	sd	ra,104(sp)
     58c:	f0a2                	sd	s0,96(sp)
     58e:	eca6                	sd	s1,88(sp)
     590:	e0d2                	sd	s4,64(sp)
     592:	fc56                	sd	s5,56(sp)
     594:	1880                	addi	s0,sp,112
     596:	8a2a                	mv	s4,a0
     598:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     59a:	00001617          	auipc	a2,0x1
     59e:	c9e60613          	addi	a2,a2,-866 # 1238 <malloc+0x170>
     5a2:	eabff0ef          	jal	44c <peek>
     5a6:	e915                	bnez	a0,5da <parseexec+0x52>
     5a8:	e8ca                	sd	s2,80(sp)
     5aa:	e4ce                	sd	s3,72(sp)
     5ac:	f85a                	sd	s6,48(sp)
     5ae:	f45e                	sd	s7,40(sp)
     5b0:	f062                	sd	s8,32(sp)
     5b2:	ec66                	sd	s9,24(sp)
     5b4:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     5b6:	c1dff0ef          	jal	1d2 <execcmd>
     5ba:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     5bc:	8656                	mv	a2,s5
     5be:	85d2                	mv	a1,s4
     5c0:	ef1ff0ef          	jal	4b0 <parseredirs>
     5c4:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     5c6:	008c0913          	addi	s2,s8,8
     5ca:	00001b17          	auipc	s6,0x1
     5ce:	c8eb0b13          	addi	s6,s6,-882 # 1258 <malloc+0x190>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     5d2:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     5d6:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     5d8:	a815                	j	60c <parseexec+0x84>
    return parseblock(ps, es);
     5da:	85d6                	mv	a1,s5
     5dc:	8552                	mv	a0,s4
     5de:	170000ef          	jal	74e <parseblock>
     5e2:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     5e4:	8526                	mv	a0,s1
     5e6:	70a6                	ld	ra,104(sp)
     5e8:	7406                	ld	s0,96(sp)
     5ea:	64e6                	ld	s1,88(sp)
     5ec:	6a06                	ld	s4,64(sp)
     5ee:	7ae2                	ld	s5,56(sp)
     5f0:	6165                	addi	sp,sp,112
     5f2:	8082                	ret
      panic("syntax");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	c4c50513          	addi	a0,a0,-948 # 1240 <malloc+0x178>
     5fc:	a4fff0ef          	jal	4a <panic>
    ret = parseredirs(ret, ps, es);
     600:	8656                	mv	a2,s5
     602:	85d2                	mv	a1,s4
     604:	8526                	mv	a0,s1
     606:	eabff0ef          	jal	4b0 <parseredirs>
     60a:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     60c:	865a                	mv	a2,s6
     60e:	85d6                	mv	a1,s5
     610:	8552                	mv	a0,s4
     612:	e3bff0ef          	jal	44c <peek>
     616:	ed15                	bnez	a0,652 <parseexec+0xca>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     618:	f9040693          	addi	a3,s0,-112
     61c:	f9840613          	addi	a2,s0,-104
     620:	85d6                	mv	a1,s5
     622:	8552                	mv	a0,s4
     624:	cedff0ef          	jal	310 <gettoken>
     628:	c50d                	beqz	a0,652 <parseexec+0xca>
    if(tok != 'a')
     62a:	fd9515e3          	bne	a0,s9,5f4 <parseexec+0x6c>
    cmd->argv[argc] = q;
     62e:	f9843783          	ld	a5,-104(s0)
     632:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     636:	f9043783          	ld	a5,-112(s0)
     63a:	04f93823          	sd	a5,80(s2)
    argc++;
     63e:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     640:	0921                	addi	s2,s2,8
     642:	fb799fe3          	bne	s3,s7,600 <parseexec+0x78>
      panic("too many args");
     646:	00001517          	auipc	a0,0x1
     64a:	c0250513          	addi	a0,a0,-1022 # 1248 <malloc+0x180>
     64e:	9fdff0ef          	jal	4a <panic>
  cmd->argv[argc] = 0;
     652:	098e                	slli	s3,s3,0x3
     654:	9c4e                	add	s8,s8,s3
     656:	000c3423          	sd	zero,8(s8)
  cmd->eargv[argc] = 0;
     65a:	040c3c23          	sd	zero,88(s8)
     65e:	6946                	ld	s2,80(sp)
     660:	69a6                	ld	s3,72(sp)
     662:	7b42                	ld	s6,48(sp)
     664:	7ba2                	ld	s7,40(sp)
     666:	7c02                	ld	s8,32(sp)
     668:	6ce2                	ld	s9,24(sp)
  return ret;
     66a:	bfad                	j	5e4 <parseexec+0x5c>

000000000000066c <parsepipe>:
{
     66c:	7179                	addi	sp,sp,-48
     66e:	f406                	sd	ra,40(sp)
     670:	f022                	sd	s0,32(sp)
     672:	ec26                	sd	s1,24(sp)
     674:	e84a                	sd	s2,16(sp)
     676:	e44e                	sd	s3,8(sp)
     678:	1800                	addi	s0,sp,48
     67a:	892a                	mv	s2,a0
     67c:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     67e:	f0bff0ef          	jal	588 <parseexec>
     682:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     684:	00001617          	auipc	a2,0x1
     688:	bdc60613          	addi	a2,a2,-1060 # 1260 <malloc+0x198>
     68c:	85ce                	mv	a1,s3
     68e:	854a                	mv	a0,s2
     690:	dbdff0ef          	jal	44c <peek>
     694:	e909                	bnez	a0,6a6 <parsepipe+0x3a>
}
     696:	8526                	mv	a0,s1
     698:	70a2                	ld	ra,40(sp)
     69a:	7402                	ld	s0,32(sp)
     69c:	64e2                	ld	s1,24(sp)
     69e:	6942                	ld	s2,16(sp)
     6a0:	69a2                	ld	s3,8(sp)
     6a2:	6145                	addi	sp,sp,48
     6a4:	8082                	ret
    gettoken(ps, es, 0, 0);
     6a6:	4681                	li	a3,0
     6a8:	4601                	li	a2,0
     6aa:	85ce                	mv	a1,s3
     6ac:	854a                	mv	a0,s2
     6ae:	c63ff0ef          	jal	310 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6b2:	85ce                	mv	a1,s3
     6b4:	854a                	mv	a0,s2
     6b6:	fb7ff0ef          	jal	66c <parsepipe>
     6ba:	85aa                	mv	a1,a0
     6bc:	8526                	mv	a0,s1
     6be:	ba3ff0ef          	jal	260 <pipecmd>
     6c2:	84aa                	mv	s1,a0
  return cmd;
     6c4:	bfc9                	j	696 <parsepipe+0x2a>

00000000000006c6 <parseline>:
{
     6c6:	7179                	addi	sp,sp,-48
     6c8:	f406                	sd	ra,40(sp)
     6ca:	f022                	sd	s0,32(sp)
     6cc:	ec26                	sd	s1,24(sp)
     6ce:	e84a                	sd	s2,16(sp)
     6d0:	e44e                	sd	s3,8(sp)
     6d2:	e052                	sd	s4,0(sp)
     6d4:	1800                	addi	s0,sp,48
     6d6:	892a                	mv	s2,a0
     6d8:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     6da:	f93ff0ef          	jal	66c <parsepipe>
     6de:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     6e0:	00001a17          	auipc	s4,0x1
     6e4:	b88a0a13          	addi	s4,s4,-1144 # 1268 <malloc+0x1a0>
     6e8:	a819                	j	6fe <parseline+0x38>
    gettoken(ps, es, 0, 0);
     6ea:	4681                	li	a3,0
     6ec:	4601                	li	a2,0
     6ee:	85ce                	mv	a1,s3
     6f0:	854a                	mv	a0,s2
     6f2:	c1fff0ef          	jal	310 <gettoken>
    cmd = backcmd(cmd);
     6f6:	8526                	mv	a0,s1
     6f8:	be5ff0ef          	jal	2dc <backcmd>
     6fc:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     6fe:	8652                	mv	a2,s4
     700:	85ce                	mv	a1,s3
     702:	854a                	mv	a0,s2
     704:	d49ff0ef          	jal	44c <peek>
     708:	f16d                	bnez	a0,6ea <parseline+0x24>
  if(peek(ps, es, ";")){
     70a:	00001617          	auipc	a2,0x1
     70e:	b6660613          	addi	a2,a2,-1178 # 1270 <malloc+0x1a8>
     712:	85ce                	mv	a1,s3
     714:	854a                	mv	a0,s2
     716:	d37ff0ef          	jal	44c <peek>
     71a:	e911                	bnez	a0,72e <parseline+0x68>
}
     71c:	8526                	mv	a0,s1
     71e:	70a2                	ld	ra,40(sp)
     720:	7402                	ld	s0,32(sp)
     722:	64e2                	ld	s1,24(sp)
     724:	6942                	ld	s2,16(sp)
     726:	69a2                	ld	s3,8(sp)
     728:	6a02                	ld	s4,0(sp)
     72a:	6145                	addi	sp,sp,48
     72c:	8082                	ret
    gettoken(ps, es, 0, 0);
     72e:	4681                	li	a3,0
     730:	4601                	li	a2,0
     732:	85ce                	mv	a1,s3
     734:	854a                	mv	a0,s2
     736:	bdbff0ef          	jal	310 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     73a:	85ce                	mv	a1,s3
     73c:	854a                	mv	a0,s2
     73e:	f89ff0ef          	jal	6c6 <parseline>
     742:	85aa                	mv	a1,a0
     744:	8526                	mv	a0,s1
     746:	b59ff0ef          	jal	29e <listcmd>
     74a:	84aa                	mv	s1,a0
  return cmd;
     74c:	bfc1                	j	71c <parseline+0x56>

000000000000074e <parseblock>:
{
     74e:	7179                	addi	sp,sp,-48
     750:	f406                	sd	ra,40(sp)
     752:	f022                	sd	s0,32(sp)
     754:	ec26                	sd	s1,24(sp)
     756:	e84a                	sd	s2,16(sp)
     758:	e44e                	sd	s3,8(sp)
     75a:	1800                	addi	s0,sp,48
     75c:	84aa                	mv	s1,a0
     75e:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     760:	00001617          	auipc	a2,0x1
     764:	ad860613          	addi	a2,a2,-1320 # 1238 <malloc+0x170>
     768:	ce5ff0ef          	jal	44c <peek>
     76c:	c539                	beqz	a0,7ba <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     76e:	4681                	li	a3,0
     770:	4601                	li	a2,0
     772:	85ca                	mv	a1,s2
     774:	8526                	mv	a0,s1
     776:	b9bff0ef          	jal	310 <gettoken>
  cmd = parseline(ps, es);
     77a:	85ca                	mv	a1,s2
     77c:	8526                	mv	a0,s1
     77e:	f49ff0ef          	jal	6c6 <parseline>
     782:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     784:	00001617          	auipc	a2,0x1
     788:	b0460613          	addi	a2,a2,-1276 # 1288 <malloc+0x1c0>
     78c:	85ca                	mv	a1,s2
     78e:	8526                	mv	a0,s1
     790:	cbdff0ef          	jal	44c <peek>
     794:	c90d                	beqz	a0,7c6 <parseblock+0x78>
  gettoken(ps, es, 0, 0);
     796:	4681                	li	a3,0
     798:	4601                	li	a2,0
     79a:	85ca                	mv	a1,s2
     79c:	8526                	mv	a0,s1
     79e:	b73ff0ef          	jal	310 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     7a2:	864a                	mv	a2,s2
     7a4:	85a6                	mv	a1,s1
     7a6:	854e                	mv	a0,s3
     7a8:	d09ff0ef          	jal	4b0 <parseredirs>
}
     7ac:	70a2                	ld	ra,40(sp)
     7ae:	7402                	ld	s0,32(sp)
     7b0:	64e2                	ld	s1,24(sp)
     7b2:	6942                	ld	s2,16(sp)
     7b4:	69a2                	ld	s3,8(sp)
     7b6:	6145                	addi	sp,sp,48
     7b8:	8082                	ret
    panic("parseblock");
     7ba:	00001517          	auipc	a0,0x1
     7be:	abe50513          	addi	a0,a0,-1346 # 1278 <malloc+0x1b0>
     7c2:	889ff0ef          	jal	4a <panic>
    panic("syntax - missing )");
     7c6:	00001517          	auipc	a0,0x1
     7ca:	aca50513          	addi	a0,a0,-1334 # 1290 <malloc+0x1c8>
     7ce:	87dff0ef          	jal	4a <panic>

00000000000007d2 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     7d2:	1101                	addi	sp,sp,-32
     7d4:	ec06                	sd	ra,24(sp)
     7d6:	e822                	sd	s0,16(sp)
     7d8:	e426                	sd	s1,8(sp)
     7da:	1000                	addi	s0,sp,32
     7dc:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     7de:	c131                	beqz	a0,822 <nulterminate+0x50>
    return 0;

  switch(cmd->type){
     7e0:	4118                	lw	a4,0(a0)
     7e2:	4795                	li	a5,5
     7e4:	02e7ef63          	bltu	a5,a4,822 <nulterminate+0x50>
     7e8:	00056783          	lwu	a5,0(a0)
     7ec:	078a                	slli	a5,a5,0x2
     7ee:	00001717          	auipc	a4,0x1
     7f2:	b0270713          	addi	a4,a4,-1278 # 12f0 <malloc+0x228>
     7f6:	97ba                	add	a5,a5,a4
     7f8:	439c                	lw	a5,0(a5)
     7fa:	97ba                	add	a5,a5,a4
     7fc:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     7fe:	651c                	ld	a5,8(a0)
     800:	c38d                	beqz	a5,822 <nulterminate+0x50>
     802:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     806:	67b8                	ld	a4,72(a5)
     808:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     80c:	07a1                	addi	a5,a5,8
     80e:	ff87b703          	ld	a4,-8(a5)
     812:	fb75                	bnez	a4,806 <nulterminate+0x34>
     814:	a039                	j	822 <nulterminate+0x50>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     816:	6508                	ld	a0,8(a0)
     818:	fbbff0ef          	jal	7d2 <nulterminate>
    *rcmd->efile = 0;
     81c:	6c9c                	ld	a5,24(s1)
     81e:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     822:	8526                	mv	a0,s1
     824:	60e2                	ld	ra,24(sp)
     826:	6442                	ld	s0,16(sp)
     828:	64a2                	ld	s1,8(sp)
     82a:	6105                	addi	sp,sp,32
     82c:	8082                	ret
    nulterminate(pcmd->left);
     82e:	6508                	ld	a0,8(a0)
     830:	fa3ff0ef          	jal	7d2 <nulterminate>
    nulterminate(pcmd->right);
     834:	6888                	ld	a0,16(s1)
     836:	f9dff0ef          	jal	7d2 <nulterminate>
    break;
     83a:	b7e5                	j	822 <nulterminate+0x50>
    nulterminate(lcmd->left);
     83c:	6508                	ld	a0,8(a0)
     83e:	f95ff0ef          	jal	7d2 <nulterminate>
    nulterminate(lcmd->right);
     842:	6888                	ld	a0,16(s1)
     844:	f8fff0ef          	jal	7d2 <nulterminate>
    break;
     848:	bfe9                	j	822 <nulterminate+0x50>
    nulterminate(bcmd->cmd);
     84a:	6508                	ld	a0,8(a0)
     84c:	f87ff0ef          	jal	7d2 <nulterminate>
    break;
     850:	bfc9                	j	822 <nulterminate+0x50>

0000000000000852 <parsecmd>:
{
     852:	7179                	addi	sp,sp,-48
     854:	f406                	sd	ra,40(sp)
     856:	f022                	sd	s0,32(sp)
     858:	ec26                	sd	s1,24(sp)
     85a:	e84a                	sd	s2,16(sp)
     85c:	1800                	addi	s0,sp,48
     85e:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     862:	84aa                	mv	s1,a0
     864:	188000ef          	jal	9ec <strlen>
     868:	1502                	slli	a0,a0,0x20
     86a:	9101                	srli	a0,a0,0x20
     86c:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     86e:	85a6                	mv	a1,s1
     870:	fd840513          	addi	a0,s0,-40
     874:	e53ff0ef          	jal	6c6 <parseline>
     878:	892a                	mv	s2,a0
  peek(&s, es, "");
     87a:	00001617          	auipc	a2,0x1
     87e:	94e60613          	addi	a2,a2,-1714 # 11c8 <malloc+0x100>
     882:	85a6                	mv	a1,s1
     884:	fd840513          	addi	a0,s0,-40
     888:	bc5ff0ef          	jal	44c <peek>
  if(s != es){
     88c:	fd843603          	ld	a2,-40(s0)
     890:	00961c63          	bne	a2,s1,8a8 <parsecmd+0x56>
  nulterminate(cmd);
     894:	854a                	mv	a0,s2
     896:	f3dff0ef          	jal	7d2 <nulterminate>
}
     89a:	854a                	mv	a0,s2
     89c:	70a2                	ld	ra,40(sp)
     89e:	7402                	ld	s0,32(sp)
     8a0:	64e2                	ld	s1,24(sp)
     8a2:	6942                	ld	s2,16(sp)
     8a4:	6145                	addi	sp,sp,48
     8a6:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     8a8:	00001597          	auipc	a1,0x1
     8ac:	a0058593          	addi	a1,a1,-1536 # 12a8 <malloc+0x1e0>
     8b0:	4509                	li	a0,2
     8b2:	738000ef          	jal	fea <fprintf>
    panic("syntax");
     8b6:	00001517          	auipc	a0,0x1
     8ba:	98a50513          	addi	a0,a0,-1654 # 1240 <malloc+0x178>
     8be:	f8cff0ef          	jal	4a <panic>

00000000000008c2 <main>:
{
     8c2:	7179                	addi	sp,sp,-48
     8c4:	f406                	sd	ra,40(sp)
     8c6:	f022                	sd	s0,32(sp)
     8c8:	ec26                	sd	s1,24(sp)
     8ca:	e84a                	sd	s2,16(sp)
     8cc:	e44e                	sd	s3,8(sp)
     8ce:	e052                	sd	s4,0(sp)
     8d0:	1800                	addi	s0,sp,48
  while((fd = open("console", O_RDWR)) >= 0){
     8d2:	00001497          	auipc	s1,0x1
     8d6:	9e648493          	addi	s1,s1,-1562 # 12b8 <malloc+0x1f0>
     8da:	4589                	li	a1,2
     8dc:	8526                	mv	a0,s1
     8de:	35e000ef          	jal	c3c <open>
     8e2:	00054763          	bltz	a0,8f0 <main+0x2e>
    if(fd >= 3){
     8e6:	4789                	li	a5,2
     8e8:	fea7d9e3          	bge	a5,a0,8da <main+0x18>
      close(fd);
     8ec:	338000ef          	jal	c24 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     8f0:	00001497          	auipc	s1,0x1
     8f4:	73048493          	addi	s1,s1,1840 # 2020 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     8f8:	06300913          	li	s2,99
     8fc:	02000993          	li	s3,32
     900:	a039                	j	90e <main+0x4c>
    if(fork1() == 0)
     902:	f66ff0ef          	jal	68 <fork1>
     906:	c93d                	beqz	a0,97c <main+0xba>
    wait(0);
     908:	4501                	li	a0,0
     90a:	2fa000ef          	jal	c04 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     90e:	06400593          	li	a1,100
     912:	8526                	mv	a0,s1
     914:	eecff0ef          	jal	0 <getcmd>
     918:	06054a63          	bltz	a0,98c <main+0xca>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     91c:	0004c783          	lbu	a5,0(s1)
     920:	ff2791e3          	bne	a5,s2,902 <main+0x40>
     924:	0014c703          	lbu	a4,1(s1)
     928:	06400793          	li	a5,100
     92c:	fcf71be3          	bne	a4,a5,902 <main+0x40>
     930:	0024c783          	lbu	a5,2(s1)
     934:	fd3797e3          	bne	a5,s3,902 <main+0x40>
      buf[strlen(buf)-1] = 0;  // chop \n
     938:	00001a17          	auipc	s4,0x1
     93c:	6e8a0a13          	addi	s4,s4,1768 # 2020 <buf.0>
     940:	8552                	mv	a0,s4
     942:	0aa000ef          	jal	9ec <strlen>
     946:	fff5079b          	addiw	a5,a0,-1
     94a:	1782                	slli	a5,a5,0x20
     94c:	9381                	srli	a5,a5,0x20
     94e:	9a3e                	add	s4,s4,a5
     950:	000a0023          	sb	zero,0(s4)
      if(chdir(buf+3) < 0)
     954:	00001517          	auipc	a0,0x1
     958:	6cf50513          	addi	a0,a0,1743 # 2023 <buf.0+0x3>
     95c:	310000ef          	jal	c6c <chdir>
     960:	fa0557e3          	bgez	a0,90e <main+0x4c>
        fprintf(2, "cannot cd %s\n", buf+3);
     964:	00001617          	auipc	a2,0x1
     968:	6bf60613          	addi	a2,a2,1727 # 2023 <buf.0+0x3>
     96c:	00001597          	auipc	a1,0x1
     970:	95458593          	addi	a1,a1,-1708 # 12c0 <malloc+0x1f8>
     974:	4509                	li	a0,2
     976:	674000ef          	jal	fea <fprintf>
     97a:	bf51                	j	90e <main+0x4c>
      runcmd(parsecmd(buf));
     97c:	00001517          	auipc	a0,0x1
     980:	6a450513          	addi	a0,a0,1700 # 2020 <buf.0>
     984:	ecfff0ef          	jal	852 <parsecmd>
     988:	f06ff0ef          	jal	8e <runcmd>
  exit(0);
     98c:	4501                	li	a0,0
     98e:	26e000ef          	jal	bfc <exit>

0000000000000992 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     992:	1141                	addi	sp,sp,-16
     994:	e406                	sd	ra,8(sp)
     996:	e022                	sd	s0,0(sp)
     998:	0800                	addi	s0,sp,16
  extern int main();
  main();
     99a:	f29ff0ef          	jal	8c2 <main>
  exit(0);
     99e:	4501                	li	a0,0
     9a0:	25c000ef          	jal	bfc <exit>

00000000000009a4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     9a4:	1141                	addi	sp,sp,-16
     9a6:	e422                	sd	s0,8(sp)
     9a8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     9aa:	87aa                	mv	a5,a0
     9ac:	0585                	addi	a1,a1,1
     9ae:	0785                	addi	a5,a5,1
     9b0:	fff5c703          	lbu	a4,-1(a1)
     9b4:	fee78fa3          	sb	a4,-1(a5)
     9b8:	fb75                	bnez	a4,9ac <strcpy+0x8>
    ;
  return os;
}
     9ba:	6422                	ld	s0,8(sp)
     9bc:	0141                	addi	sp,sp,16
     9be:	8082                	ret

00000000000009c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     9c0:	1141                	addi	sp,sp,-16
     9c2:	e422                	sd	s0,8(sp)
     9c4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     9c6:	00054783          	lbu	a5,0(a0)
     9ca:	cb91                	beqz	a5,9de <strcmp+0x1e>
     9cc:	0005c703          	lbu	a4,0(a1)
     9d0:	00f71763          	bne	a4,a5,9de <strcmp+0x1e>
    p++, q++;
     9d4:	0505                	addi	a0,a0,1
     9d6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     9d8:	00054783          	lbu	a5,0(a0)
     9dc:	fbe5                	bnez	a5,9cc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     9de:	0005c503          	lbu	a0,0(a1)
}
     9e2:	40a7853b          	subw	a0,a5,a0
     9e6:	6422                	ld	s0,8(sp)
     9e8:	0141                	addi	sp,sp,16
     9ea:	8082                	ret

00000000000009ec <strlen>:

uint
strlen(const char *s)
{
     9ec:	1141                	addi	sp,sp,-16
     9ee:	e422                	sd	s0,8(sp)
     9f0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     9f2:	00054783          	lbu	a5,0(a0)
     9f6:	cf91                	beqz	a5,a12 <strlen+0x26>
     9f8:	0505                	addi	a0,a0,1
     9fa:	87aa                	mv	a5,a0
     9fc:	86be                	mv	a3,a5
     9fe:	0785                	addi	a5,a5,1
     a00:	fff7c703          	lbu	a4,-1(a5)
     a04:	ff65                	bnez	a4,9fc <strlen+0x10>
     a06:	40a6853b          	subw	a0,a3,a0
     a0a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     a0c:	6422                	ld	s0,8(sp)
     a0e:	0141                	addi	sp,sp,16
     a10:	8082                	ret
  for(n = 0; s[n]; n++)
     a12:	4501                	li	a0,0
     a14:	bfe5                	j	a0c <strlen+0x20>

0000000000000a16 <memset>:

void*
memset(void *dst, int c, uint n)
{
     a16:	1141                	addi	sp,sp,-16
     a18:	e422                	sd	s0,8(sp)
     a1a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a1c:	ca19                	beqz	a2,a32 <memset+0x1c>
     a1e:	87aa                	mv	a5,a0
     a20:	1602                	slli	a2,a2,0x20
     a22:	9201                	srli	a2,a2,0x20
     a24:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a28:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     a2c:	0785                	addi	a5,a5,1
     a2e:	fee79de3          	bne	a5,a4,a28 <memset+0x12>
  }
  return dst;
}
     a32:	6422                	ld	s0,8(sp)
     a34:	0141                	addi	sp,sp,16
     a36:	8082                	ret

0000000000000a38 <strchr>:

char*
strchr(const char *s, char c)
{
     a38:	1141                	addi	sp,sp,-16
     a3a:	e422                	sd	s0,8(sp)
     a3c:	0800                	addi	s0,sp,16
  for(; *s; s++)
     a3e:	00054783          	lbu	a5,0(a0)
     a42:	cb99                	beqz	a5,a58 <strchr+0x20>
    if(*s == c)
     a44:	00f58763          	beq	a1,a5,a52 <strchr+0x1a>
  for(; *s; s++)
     a48:	0505                	addi	a0,a0,1
     a4a:	00054783          	lbu	a5,0(a0)
     a4e:	fbfd                	bnez	a5,a44 <strchr+0xc>
      return (char*)s;
  return 0;
     a50:	4501                	li	a0,0
}
     a52:	6422                	ld	s0,8(sp)
     a54:	0141                	addi	sp,sp,16
     a56:	8082                	ret
  return 0;
     a58:	4501                	li	a0,0
     a5a:	bfe5                	j	a52 <strchr+0x1a>

0000000000000a5c <gets>:

char*
gets(char *buf, int max)
{
     a5c:	711d                	addi	sp,sp,-96
     a5e:	ec86                	sd	ra,88(sp)
     a60:	e8a2                	sd	s0,80(sp)
     a62:	e4a6                	sd	s1,72(sp)
     a64:	e0ca                	sd	s2,64(sp)
     a66:	fc4e                	sd	s3,56(sp)
     a68:	f852                	sd	s4,48(sp)
     a6a:	f456                	sd	s5,40(sp)
     a6c:	f05a                	sd	s6,32(sp)
     a6e:	ec5e                	sd	s7,24(sp)
     a70:	1080                	addi	s0,sp,96
     a72:	8baa                	mv	s7,a0
     a74:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a76:	892a                	mv	s2,a0
     a78:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     a7a:	4aa9                	li	s5,10
     a7c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     a7e:	89a6                	mv	s3,s1
     a80:	2485                	addiw	s1,s1,1
     a82:	0344d663          	bge	s1,s4,aae <gets+0x52>
    cc = read(0, &c, 1);
     a86:	4605                	li	a2,1
     a88:	faf40593          	addi	a1,s0,-81
     a8c:	4501                	li	a0,0
     a8e:	186000ef          	jal	c14 <read>
    if(cc < 1)
     a92:	00a05e63          	blez	a0,aae <gets+0x52>
    buf[i++] = c;
     a96:	faf44783          	lbu	a5,-81(s0)
     a9a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     a9e:	01578763          	beq	a5,s5,aac <gets+0x50>
     aa2:	0905                	addi	s2,s2,1
     aa4:	fd679de3          	bne	a5,s6,a7e <gets+0x22>
    buf[i++] = c;
     aa8:	89a6                	mv	s3,s1
     aaa:	a011                	j	aae <gets+0x52>
     aac:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     aae:	99de                	add	s3,s3,s7
     ab0:	00098023          	sb	zero,0(s3)
  return buf;
}
     ab4:	855e                	mv	a0,s7
     ab6:	60e6                	ld	ra,88(sp)
     ab8:	6446                	ld	s0,80(sp)
     aba:	64a6                	ld	s1,72(sp)
     abc:	6906                	ld	s2,64(sp)
     abe:	79e2                	ld	s3,56(sp)
     ac0:	7a42                	ld	s4,48(sp)
     ac2:	7aa2                	ld	s5,40(sp)
     ac4:	7b02                	ld	s6,32(sp)
     ac6:	6be2                	ld	s7,24(sp)
     ac8:	6125                	addi	sp,sp,96
     aca:	8082                	ret

0000000000000acc <stat>:

int
stat(const char *n, struct stat *st)
{
     acc:	1101                	addi	sp,sp,-32
     ace:	ec06                	sd	ra,24(sp)
     ad0:	e822                	sd	s0,16(sp)
     ad2:	e04a                	sd	s2,0(sp)
     ad4:	1000                	addi	s0,sp,32
     ad6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ad8:	4581                	li	a1,0
     ada:	162000ef          	jal	c3c <open>
  if(fd < 0)
     ade:	02054263          	bltz	a0,b02 <stat+0x36>
     ae2:	e426                	sd	s1,8(sp)
     ae4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     ae6:	85ca                	mv	a1,s2
     ae8:	16c000ef          	jal	c54 <fstat>
     aec:	892a                	mv	s2,a0
  close(fd);
     aee:	8526                	mv	a0,s1
     af0:	134000ef          	jal	c24 <close>
  return r;
     af4:	64a2                	ld	s1,8(sp)
}
     af6:	854a                	mv	a0,s2
     af8:	60e2                	ld	ra,24(sp)
     afa:	6442                	ld	s0,16(sp)
     afc:	6902                	ld	s2,0(sp)
     afe:	6105                	addi	sp,sp,32
     b00:	8082                	ret
    return -1;
     b02:	597d                	li	s2,-1
     b04:	bfcd                	j	af6 <stat+0x2a>

0000000000000b06 <atoi>:

int
atoi(const char *s)
{
     b06:	1141                	addi	sp,sp,-16
     b08:	e422                	sd	s0,8(sp)
     b0a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b0c:	00054683          	lbu	a3,0(a0)
     b10:	fd06879b          	addiw	a5,a3,-48
     b14:	0ff7f793          	zext.b	a5,a5
     b18:	4625                	li	a2,9
     b1a:	02f66863          	bltu	a2,a5,b4a <atoi+0x44>
     b1e:	872a                	mv	a4,a0
  n = 0;
     b20:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     b22:	0705                	addi	a4,a4,1
     b24:	0025179b          	slliw	a5,a0,0x2
     b28:	9fa9                	addw	a5,a5,a0
     b2a:	0017979b          	slliw	a5,a5,0x1
     b2e:	9fb5                	addw	a5,a5,a3
     b30:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     b34:	00074683          	lbu	a3,0(a4)
     b38:	fd06879b          	addiw	a5,a3,-48
     b3c:	0ff7f793          	zext.b	a5,a5
     b40:	fef671e3          	bgeu	a2,a5,b22 <atoi+0x1c>
  return n;
}
     b44:	6422                	ld	s0,8(sp)
     b46:	0141                	addi	sp,sp,16
     b48:	8082                	ret
  n = 0;
     b4a:	4501                	li	a0,0
     b4c:	bfe5                	j	b44 <atoi+0x3e>

0000000000000b4e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     b4e:	1141                	addi	sp,sp,-16
     b50:	e422                	sd	s0,8(sp)
     b52:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     b54:	02b57463          	bgeu	a0,a1,b7c <memmove+0x2e>
    while(n-- > 0)
     b58:	00c05f63          	blez	a2,b76 <memmove+0x28>
     b5c:	1602                	slli	a2,a2,0x20
     b5e:	9201                	srli	a2,a2,0x20
     b60:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     b64:	872a                	mv	a4,a0
      *dst++ = *src++;
     b66:	0585                	addi	a1,a1,1
     b68:	0705                	addi	a4,a4,1
     b6a:	fff5c683          	lbu	a3,-1(a1)
     b6e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     b72:	fef71ae3          	bne	a4,a5,b66 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     b76:	6422                	ld	s0,8(sp)
     b78:	0141                	addi	sp,sp,16
     b7a:	8082                	ret
    dst += n;
     b7c:	00c50733          	add	a4,a0,a2
    src += n;
     b80:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     b82:	fec05ae3          	blez	a2,b76 <memmove+0x28>
     b86:	fff6079b          	addiw	a5,a2,-1
     b8a:	1782                	slli	a5,a5,0x20
     b8c:	9381                	srli	a5,a5,0x20
     b8e:	fff7c793          	not	a5,a5
     b92:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     b94:	15fd                	addi	a1,a1,-1
     b96:	177d                	addi	a4,a4,-1
     b98:	0005c683          	lbu	a3,0(a1)
     b9c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     ba0:	fee79ae3          	bne	a5,a4,b94 <memmove+0x46>
     ba4:	bfc9                	j	b76 <memmove+0x28>

0000000000000ba6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     ba6:	1141                	addi	sp,sp,-16
     ba8:	e422                	sd	s0,8(sp)
     baa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     bac:	ca05                	beqz	a2,bdc <memcmp+0x36>
     bae:	fff6069b          	addiw	a3,a2,-1
     bb2:	1682                	slli	a3,a3,0x20
     bb4:	9281                	srli	a3,a3,0x20
     bb6:	0685                	addi	a3,a3,1
     bb8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     bba:	00054783          	lbu	a5,0(a0)
     bbe:	0005c703          	lbu	a4,0(a1)
     bc2:	00e79863          	bne	a5,a4,bd2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     bc6:	0505                	addi	a0,a0,1
    p2++;
     bc8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     bca:	fed518e3          	bne	a0,a3,bba <memcmp+0x14>
  }
  return 0;
     bce:	4501                	li	a0,0
     bd0:	a019                	j	bd6 <memcmp+0x30>
      return *p1 - *p2;
     bd2:	40e7853b          	subw	a0,a5,a4
}
     bd6:	6422                	ld	s0,8(sp)
     bd8:	0141                	addi	sp,sp,16
     bda:	8082                	ret
  return 0;
     bdc:	4501                	li	a0,0
     bde:	bfe5                	j	bd6 <memcmp+0x30>

0000000000000be0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     be0:	1141                	addi	sp,sp,-16
     be2:	e406                	sd	ra,8(sp)
     be4:	e022                	sd	s0,0(sp)
     be6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     be8:	f67ff0ef          	jal	b4e <memmove>
}
     bec:	60a2                	ld	ra,8(sp)
     bee:	6402                	ld	s0,0(sp)
     bf0:	0141                	addi	sp,sp,16
     bf2:	8082                	ret

0000000000000bf4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     bf4:	4885                	li	a7,1
 ecall
     bf6:	00000073          	ecall
 ret
     bfa:	8082                	ret

0000000000000bfc <exit>:
.global exit
exit:
 li a7, SYS_exit
     bfc:	4889                	li	a7,2
 ecall
     bfe:	00000073          	ecall
 ret
     c02:	8082                	ret

0000000000000c04 <wait>:
.global wait
wait:
 li a7, SYS_wait
     c04:	488d                	li	a7,3
 ecall
     c06:	00000073          	ecall
 ret
     c0a:	8082                	ret

0000000000000c0c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c0c:	4891                	li	a7,4
 ecall
     c0e:	00000073          	ecall
 ret
     c12:	8082                	ret

0000000000000c14 <read>:
.global read
read:
 li a7, SYS_read
     c14:	4895                	li	a7,5
 ecall
     c16:	00000073          	ecall
 ret
     c1a:	8082                	ret

0000000000000c1c <write>:
.global write
write:
 li a7, SYS_write
     c1c:	48c1                	li	a7,16
 ecall
     c1e:	00000073          	ecall
 ret
     c22:	8082                	ret

0000000000000c24 <close>:
.global close
close:
 li a7, SYS_close
     c24:	48d5                	li	a7,21
 ecall
     c26:	00000073          	ecall
 ret
     c2a:	8082                	ret

0000000000000c2c <kill>:
.global kill
kill:
 li a7, SYS_kill
     c2c:	4899                	li	a7,6
 ecall
     c2e:	00000073          	ecall
 ret
     c32:	8082                	ret

0000000000000c34 <exec>:
.global exec
exec:
 li a7, SYS_exec
     c34:	489d                	li	a7,7
 ecall
     c36:	00000073          	ecall
 ret
     c3a:	8082                	ret

0000000000000c3c <open>:
.global open
open:
 li a7, SYS_open
     c3c:	48bd                	li	a7,15
 ecall
     c3e:	00000073          	ecall
 ret
     c42:	8082                	ret

0000000000000c44 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     c44:	48c5                	li	a7,17
 ecall
     c46:	00000073          	ecall
 ret
     c4a:	8082                	ret

0000000000000c4c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     c4c:	48c9                	li	a7,18
 ecall
     c4e:	00000073          	ecall
 ret
     c52:	8082                	ret

0000000000000c54 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     c54:	48a1                	li	a7,8
 ecall
     c56:	00000073          	ecall
 ret
     c5a:	8082                	ret

0000000000000c5c <link>:
.global link
link:
 li a7, SYS_link
     c5c:	48cd                	li	a7,19
 ecall
     c5e:	00000073          	ecall
 ret
     c62:	8082                	ret

0000000000000c64 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     c64:	48d1                	li	a7,20
 ecall
     c66:	00000073          	ecall
 ret
     c6a:	8082                	ret

0000000000000c6c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     c6c:	48a5                	li	a7,9
 ecall
     c6e:	00000073          	ecall
 ret
     c72:	8082                	ret

0000000000000c74 <dup>:
.global dup
dup:
 li a7, SYS_dup
     c74:	48a9                	li	a7,10
 ecall
     c76:	00000073          	ecall
 ret
     c7a:	8082                	ret

0000000000000c7c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     c7c:	48ad                	li	a7,11
 ecall
     c7e:	00000073          	ecall
 ret
     c82:	8082                	ret

0000000000000c84 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     c84:	48b1                	li	a7,12
 ecall
     c86:	00000073          	ecall
 ret
     c8a:	8082                	ret

0000000000000c8c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     c8c:	48b5                	li	a7,13
 ecall
     c8e:	00000073          	ecall
 ret
     c92:	8082                	ret

0000000000000c94 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     c94:	48b9                	li	a7,14
 ecall
     c96:	00000073          	ecall
 ret
     c9a:	8082                	ret

0000000000000c9c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     c9c:	1101                	addi	sp,sp,-32
     c9e:	ec06                	sd	ra,24(sp)
     ca0:	e822                	sd	s0,16(sp)
     ca2:	1000                	addi	s0,sp,32
     ca4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ca8:	4605                	li	a2,1
     caa:	fef40593          	addi	a1,s0,-17
     cae:	f6fff0ef          	jal	c1c <write>
}
     cb2:	60e2                	ld	ra,24(sp)
     cb4:	6442                	ld	s0,16(sp)
     cb6:	6105                	addi	sp,sp,32
     cb8:	8082                	ret

0000000000000cba <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     cba:	7139                	addi	sp,sp,-64
     cbc:	fc06                	sd	ra,56(sp)
     cbe:	f822                	sd	s0,48(sp)
     cc0:	f426                	sd	s1,40(sp)
     cc2:	0080                	addi	s0,sp,64
     cc4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     cc6:	c299                	beqz	a3,ccc <printint+0x12>
     cc8:	0805c963          	bltz	a1,d5a <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     ccc:	2581                	sext.w	a1,a1
  neg = 0;
     cce:	4881                	li	a7,0
     cd0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     cd4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     cd6:	2601                	sext.w	a2,a2
     cd8:	00000517          	auipc	a0,0x0
     cdc:	63050513          	addi	a0,a0,1584 # 1308 <digits>
     ce0:	883a                	mv	a6,a4
     ce2:	2705                	addiw	a4,a4,1
     ce4:	02c5f7bb          	remuw	a5,a1,a2
     ce8:	1782                	slli	a5,a5,0x20
     cea:	9381                	srli	a5,a5,0x20
     cec:	97aa                	add	a5,a5,a0
     cee:	0007c783          	lbu	a5,0(a5)
     cf2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     cf6:	0005879b          	sext.w	a5,a1
     cfa:	02c5d5bb          	divuw	a1,a1,a2
     cfe:	0685                	addi	a3,a3,1
     d00:	fec7f0e3          	bgeu	a5,a2,ce0 <printint+0x26>
  if(neg)
     d04:	00088c63          	beqz	a7,d1c <printint+0x62>
    buf[i++] = '-';
     d08:	fd070793          	addi	a5,a4,-48
     d0c:	00878733          	add	a4,a5,s0
     d10:	02d00793          	li	a5,45
     d14:	fef70823          	sb	a5,-16(a4)
     d18:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     d1c:	02e05a63          	blez	a4,d50 <printint+0x96>
     d20:	f04a                	sd	s2,32(sp)
     d22:	ec4e                	sd	s3,24(sp)
     d24:	fc040793          	addi	a5,s0,-64
     d28:	00e78933          	add	s2,a5,a4
     d2c:	fff78993          	addi	s3,a5,-1
     d30:	99ba                	add	s3,s3,a4
     d32:	377d                	addiw	a4,a4,-1
     d34:	1702                	slli	a4,a4,0x20
     d36:	9301                	srli	a4,a4,0x20
     d38:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     d3c:	fff94583          	lbu	a1,-1(s2)
     d40:	8526                	mv	a0,s1
     d42:	f5bff0ef          	jal	c9c <putc>
  while(--i >= 0)
     d46:	197d                	addi	s2,s2,-1
     d48:	ff391ae3          	bne	s2,s3,d3c <printint+0x82>
     d4c:	7902                	ld	s2,32(sp)
     d4e:	69e2                	ld	s3,24(sp)
}
     d50:	70e2                	ld	ra,56(sp)
     d52:	7442                	ld	s0,48(sp)
     d54:	74a2                	ld	s1,40(sp)
     d56:	6121                	addi	sp,sp,64
     d58:	8082                	ret
    x = -xx;
     d5a:	40b005bb          	negw	a1,a1
    neg = 1;
     d5e:	4885                	li	a7,1
    x = -xx;
     d60:	bf85                	j	cd0 <printint+0x16>

0000000000000d62 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d62:	711d                	addi	sp,sp,-96
     d64:	ec86                	sd	ra,88(sp)
     d66:	e8a2                	sd	s0,80(sp)
     d68:	e0ca                	sd	s2,64(sp)
     d6a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     d6c:	0005c903          	lbu	s2,0(a1)
     d70:	26090863          	beqz	s2,fe0 <vprintf+0x27e>
     d74:	e4a6                	sd	s1,72(sp)
     d76:	fc4e                	sd	s3,56(sp)
     d78:	f852                	sd	s4,48(sp)
     d7a:	f456                	sd	s5,40(sp)
     d7c:	f05a                	sd	s6,32(sp)
     d7e:	ec5e                	sd	s7,24(sp)
     d80:	e862                	sd	s8,16(sp)
     d82:	e466                	sd	s9,8(sp)
     d84:	8b2a                	mv	s6,a0
     d86:	8a2e                	mv	s4,a1
     d88:	8bb2                	mv	s7,a2
  state = 0;
     d8a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     d8c:	4481                	li	s1,0
     d8e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     d90:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     d94:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     d98:	06c00c93          	li	s9,108
     d9c:	a005                	j	dbc <vprintf+0x5a>
        putc(fd, c0);
     d9e:	85ca                	mv	a1,s2
     da0:	855a                	mv	a0,s6
     da2:	efbff0ef          	jal	c9c <putc>
     da6:	a019                	j	dac <vprintf+0x4a>
    } else if(state == '%'){
     da8:	03598263          	beq	s3,s5,dcc <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     dac:	2485                	addiw	s1,s1,1
     dae:	8726                	mv	a4,s1
     db0:	009a07b3          	add	a5,s4,s1
     db4:	0007c903          	lbu	s2,0(a5)
     db8:	20090c63          	beqz	s2,fd0 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
     dbc:	0009079b          	sext.w	a5,s2
    if(state == 0){
     dc0:	fe0994e3          	bnez	s3,da8 <vprintf+0x46>
      if(c0 == '%'){
     dc4:	fd579de3          	bne	a5,s5,d9e <vprintf+0x3c>
        state = '%';
     dc8:	89be                	mv	s3,a5
     dca:	b7cd                	j	dac <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     dcc:	00ea06b3          	add	a3,s4,a4
     dd0:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     dd4:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     dd6:	c681                	beqz	a3,dde <vprintf+0x7c>
     dd8:	9752                	add	a4,a4,s4
     dda:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     dde:	03878f63          	beq	a5,s8,e1c <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
     de2:	05978963          	beq	a5,s9,e34 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     de6:	07500713          	li	a4,117
     dea:	0ee78363          	beq	a5,a4,ed0 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     dee:	07800713          	li	a4,120
     df2:	12e78563          	beq	a5,a4,f1c <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     df6:	07000713          	li	a4,112
     dfa:	14e78a63          	beq	a5,a4,f4e <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
     dfe:	07300713          	li	a4,115
     e02:	18e78a63          	beq	a5,a4,f96 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     e06:	02500713          	li	a4,37
     e0a:	04e79563          	bne	a5,a4,e54 <vprintf+0xf2>
        putc(fd, '%');
     e0e:	02500593          	li	a1,37
     e12:	855a                	mv	a0,s6
     e14:	e89ff0ef          	jal	c9c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
     e18:	4981                	li	s3,0
     e1a:	bf49                	j	dac <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     e1c:	008b8913          	addi	s2,s7,8
     e20:	4685                	li	a3,1
     e22:	4629                	li	a2,10
     e24:	000ba583          	lw	a1,0(s7)
     e28:	855a                	mv	a0,s6
     e2a:	e91ff0ef          	jal	cba <printint>
     e2e:	8bca                	mv	s7,s2
      state = 0;
     e30:	4981                	li	s3,0
     e32:	bfad                	j	dac <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     e34:	06400793          	li	a5,100
     e38:	02f68963          	beq	a3,a5,e6a <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e3c:	06c00793          	li	a5,108
     e40:	04f68263          	beq	a3,a5,e84 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
     e44:	07500793          	li	a5,117
     e48:	0af68063          	beq	a3,a5,ee8 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
     e4c:	07800793          	li	a5,120
     e50:	0ef68263          	beq	a3,a5,f34 <vprintf+0x1d2>
        putc(fd, '%');
     e54:	02500593          	li	a1,37
     e58:	855a                	mv	a0,s6
     e5a:	e43ff0ef          	jal	c9c <putc>
        putc(fd, c0);
     e5e:	85ca                	mv	a1,s2
     e60:	855a                	mv	a0,s6
     e62:	e3bff0ef          	jal	c9c <putc>
      state = 0;
     e66:	4981                	li	s3,0
     e68:	b791                	j	dac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e6a:	008b8913          	addi	s2,s7,8
     e6e:	4685                	li	a3,1
     e70:	4629                	li	a2,10
     e72:	000ba583          	lw	a1,0(s7)
     e76:	855a                	mv	a0,s6
     e78:	e43ff0ef          	jal	cba <printint>
        i += 1;
     e7c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     e7e:	8bca                	mv	s7,s2
      state = 0;
     e80:	4981                	li	s3,0
        i += 1;
     e82:	b72d                	j	dac <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e84:	06400793          	li	a5,100
     e88:	02f60763          	beq	a2,a5,eb6 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     e8c:	07500793          	li	a5,117
     e90:	06f60963          	beq	a2,a5,f02 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     e94:	07800793          	li	a5,120
     e98:	faf61ee3          	bne	a2,a5,e54 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
     e9c:	008b8913          	addi	s2,s7,8
     ea0:	4681                	li	a3,0
     ea2:	4641                	li	a2,16
     ea4:	000ba583          	lw	a1,0(s7)
     ea8:	855a                	mv	a0,s6
     eaa:	e11ff0ef          	jal	cba <printint>
        i += 2;
     eae:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     eb0:	8bca                	mv	s7,s2
      state = 0;
     eb2:	4981                	li	s3,0
        i += 2;
     eb4:	bde5                	j	dac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     eb6:	008b8913          	addi	s2,s7,8
     eba:	4685                	li	a3,1
     ebc:	4629                	li	a2,10
     ebe:	000ba583          	lw	a1,0(s7)
     ec2:	855a                	mv	a0,s6
     ec4:	df7ff0ef          	jal	cba <printint>
        i += 2;
     ec8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     eca:	8bca                	mv	s7,s2
      state = 0;
     ecc:	4981                	li	s3,0
        i += 2;
     ece:	bdf9                	j	dac <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
     ed0:	008b8913          	addi	s2,s7,8
     ed4:	4681                	li	a3,0
     ed6:	4629                	li	a2,10
     ed8:	000ba583          	lw	a1,0(s7)
     edc:	855a                	mv	a0,s6
     ede:	dddff0ef          	jal	cba <printint>
     ee2:	8bca                	mv	s7,s2
      state = 0;
     ee4:	4981                	li	s3,0
     ee6:	b5d9                	j	dac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ee8:	008b8913          	addi	s2,s7,8
     eec:	4681                	li	a3,0
     eee:	4629                	li	a2,10
     ef0:	000ba583          	lw	a1,0(s7)
     ef4:	855a                	mv	a0,s6
     ef6:	dc5ff0ef          	jal	cba <printint>
        i += 1;
     efa:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     efc:	8bca                	mv	s7,s2
      state = 0;
     efe:	4981                	li	s3,0
        i += 1;
     f00:	b575                	j	dac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f02:	008b8913          	addi	s2,s7,8
     f06:	4681                	li	a3,0
     f08:	4629                	li	a2,10
     f0a:	000ba583          	lw	a1,0(s7)
     f0e:	855a                	mv	a0,s6
     f10:	dabff0ef          	jal	cba <printint>
        i += 2;
     f14:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     f16:	8bca                	mv	s7,s2
      state = 0;
     f18:	4981                	li	s3,0
        i += 2;
     f1a:	bd49                	j	dac <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
     f1c:	008b8913          	addi	s2,s7,8
     f20:	4681                	li	a3,0
     f22:	4641                	li	a2,16
     f24:	000ba583          	lw	a1,0(s7)
     f28:	855a                	mv	a0,s6
     f2a:	d91ff0ef          	jal	cba <printint>
     f2e:	8bca                	mv	s7,s2
      state = 0;
     f30:	4981                	li	s3,0
     f32:	bdad                	j	dac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f34:	008b8913          	addi	s2,s7,8
     f38:	4681                	li	a3,0
     f3a:	4641                	li	a2,16
     f3c:	000ba583          	lw	a1,0(s7)
     f40:	855a                	mv	a0,s6
     f42:	d79ff0ef          	jal	cba <printint>
        i += 1;
     f46:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     f48:	8bca                	mv	s7,s2
      state = 0;
     f4a:	4981                	li	s3,0
        i += 1;
     f4c:	b585                	j	dac <vprintf+0x4a>
     f4e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
     f50:	008b8d13          	addi	s10,s7,8
     f54:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     f58:	03000593          	li	a1,48
     f5c:	855a                	mv	a0,s6
     f5e:	d3fff0ef          	jal	c9c <putc>
  putc(fd, 'x');
     f62:	07800593          	li	a1,120
     f66:	855a                	mv	a0,s6
     f68:	d35ff0ef          	jal	c9c <putc>
     f6c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     f6e:	00000b97          	auipc	s7,0x0
     f72:	39ab8b93          	addi	s7,s7,922 # 1308 <digits>
     f76:	03c9d793          	srli	a5,s3,0x3c
     f7a:	97de                	add	a5,a5,s7
     f7c:	0007c583          	lbu	a1,0(a5)
     f80:	855a                	mv	a0,s6
     f82:	d1bff0ef          	jal	c9c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     f86:	0992                	slli	s3,s3,0x4
     f88:	397d                	addiw	s2,s2,-1
     f8a:	fe0916e3          	bnez	s2,f76 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
     f8e:	8bea                	mv	s7,s10
      state = 0;
     f90:	4981                	li	s3,0
     f92:	6d02                	ld	s10,0(sp)
     f94:	bd21                	j	dac <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
     f96:	008b8993          	addi	s3,s7,8
     f9a:	000bb903          	ld	s2,0(s7)
     f9e:	00090f63          	beqz	s2,fbc <vprintf+0x25a>
        for(; *s; s++)
     fa2:	00094583          	lbu	a1,0(s2)
     fa6:	c195                	beqz	a1,fca <vprintf+0x268>
          putc(fd, *s);
     fa8:	855a                	mv	a0,s6
     faa:	cf3ff0ef          	jal	c9c <putc>
        for(; *s; s++)
     fae:	0905                	addi	s2,s2,1
     fb0:	00094583          	lbu	a1,0(s2)
     fb4:	f9f5                	bnez	a1,fa8 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     fb6:	8bce                	mv	s7,s3
      state = 0;
     fb8:	4981                	li	s3,0
     fba:	bbcd                	j	dac <vprintf+0x4a>
          s = "(null)";
     fbc:	00000917          	auipc	s2,0x0
     fc0:	31490913          	addi	s2,s2,788 # 12d0 <malloc+0x208>
        for(; *s; s++)
     fc4:	02800593          	li	a1,40
     fc8:	b7c5                	j	fa8 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     fca:	8bce                	mv	s7,s3
      state = 0;
     fcc:	4981                	li	s3,0
     fce:	bbf9                	j	dac <vprintf+0x4a>
     fd0:	64a6                	ld	s1,72(sp)
     fd2:	79e2                	ld	s3,56(sp)
     fd4:	7a42                	ld	s4,48(sp)
     fd6:	7aa2                	ld	s5,40(sp)
     fd8:	7b02                	ld	s6,32(sp)
     fda:	6be2                	ld	s7,24(sp)
     fdc:	6c42                	ld	s8,16(sp)
     fde:	6ca2                	ld	s9,8(sp)
    }
  }
}
     fe0:	60e6                	ld	ra,88(sp)
     fe2:	6446                	ld	s0,80(sp)
     fe4:	6906                	ld	s2,64(sp)
     fe6:	6125                	addi	sp,sp,96
     fe8:	8082                	ret

0000000000000fea <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     fea:	715d                	addi	sp,sp,-80
     fec:	ec06                	sd	ra,24(sp)
     fee:	e822                	sd	s0,16(sp)
     ff0:	1000                	addi	s0,sp,32
     ff2:	e010                	sd	a2,0(s0)
     ff4:	e414                	sd	a3,8(s0)
     ff6:	e818                	sd	a4,16(s0)
     ff8:	ec1c                	sd	a5,24(s0)
     ffa:	03043023          	sd	a6,32(s0)
     ffe:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1002:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1006:	8622                	mv	a2,s0
    1008:	d5bff0ef          	jal	d62 <vprintf>
}
    100c:	60e2                	ld	ra,24(sp)
    100e:	6442                	ld	s0,16(sp)
    1010:	6161                	addi	sp,sp,80
    1012:	8082                	ret

0000000000001014 <printf>:

void
printf(const char *fmt, ...)
{
    1014:	711d                	addi	sp,sp,-96
    1016:	ec06                	sd	ra,24(sp)
    1018:	e822                	sd	s0,16(sp)
    101a:	1000                	addi	s0,sp,32
    101c:	e40c                	sd	a1,8(s0)
    101e:	e810                	sd	a2,16(s0)
    1020:	ec14                	sd	a3,24(s0)
    1022:	f018                	sd	a4,32(s0)
    1024:	f41c                	sd	a5,40(s0)
    1026:	03043823          	sd	a6,48(s0)
    102a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    102e:	00840613          	addi	a2,s0,8
    1032:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1036:	85aa                	mv	a1,a0
    1038:	4505                	li	a0,1
    103a:	d29ff0ef          	jal	d62 <vprintf>
}
    103e:	60e2                	ld	ra,24(sp)
    1040:	6442                	ld	s0,16(sp)
    1042:	6125                	addi	sp,sp,96
    1044:	8082                	ret

0000000000001046 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1046:	1141                	addi	sp,sp,-16
    1048:	e422                	sd	s0,8(sp)
    104a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    104c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1050:	00001797          	auipc	a5,0x1
    1054:	fc07b783          	ld	a5,-64(a5) # 2010 <freep>
    1058:	a02d                	j	1082 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    105a:	4618                	lw	a4,8(a2)
    105c:	9f2d                	addw	a4,a4,a1
    105e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1062:	6398                	ld	a4,0(a5)
    1064:	6310                	ld	a2,0(a4)
    1066:	a83d                	j	10a4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1068:	ff852703          	lw	a4,-8(a0)
    106c:	9f31                	addw	a4,a4,a2
    106e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1070:	ff053683          	ld	a3,-16(a0)
    1074:	a091                	j	10b8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1076:	6398                	ld	a4,0(a5)
    1078:	00e7e463          	bltu	a5,a4,1080 <free+0x3a>
    107c:	00e6ea63          	bltu	a3,a4,1090 <free+0x4a>
{
    1080:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1082:	fed7fae3          	bgeu	a5,a3,1076 <free+0x30>
    1086:	6398                	ld	a4,0(a5)
    1088:	00e6e463          	bltu	a3,a4,1090 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    108c:	fee7eae3          	bltu	a5,a4,1080 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1090:	ff852583          	lw	a1,-8(a0)
    1094:	6390                	ld	a2,0(a5)
    1096:	02059813          	slli	a6,a1,0x20
    109a:	01c85713          	srli	a4,a6,0x1c
    109e:	9736                	add	a4,a4,a3
    10a0:	fae60de3          	beq	a2,a4,105a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    10a4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    10a8:	4790                	lw	a2,8(a5)
    10aa:	02061593          	slli	a1,a2,0x20
    10ae:	01c5d713          	srli	a4,a1,0x1c
    10b2:	973e                	add	a4,a4,a5
    10b4:	fae68ae3          	beq	a3,a4,1068 <free+0x22>
    p->s.ptr = bp->s.ptr;
    10b8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    10ba:	00001717          	auipc	a4,0x1
    10be:	f4f73b23          	sd	a5,-170(a4) # 2010 <freep>
}
    10c2:	6422                	ld	s0,8(sp)
    10c4:	0141                	addi	sp,sp,16
    10c6:	8082                	ret

00000000000010c8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    10c8:	7139                	addi	sp,sp,-64
    10ca:	fc06                	sd	ra,56(sp)
    10cc:	f822                	sd	s0,48(sp)
    10ce:	f426                	sd	s1,40(sp)
    10d0:	ec4e                	sd	s3,24(sp)
    10d2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10d4:	02051493          	slli	s1,a0,0x20
    10d8:	9081                	srli	s1,s1,0x20
    10da:	04bd                	addi	s1,s1,15
    10dc:	8091                	srli	s1,s1,0x4
    10de:	0014899b          	addiw	s3,s1,1
    10e2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    10e4:	00001517          	auipc	a0,0x1
    10e8:	f2c53503          	ld	a0,-212(a0) # 2010 <freep>
    10ec:	c915                	beqz	a0,1120 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10ee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    10f0:	4798                	lw	a4,8(a5)
    10f2:	08977a63          	bgeu	a4,s1,1186 <malloc+0xbe>
    10f6:	f04a                	sd	s2,32(sp)
    10f8:	e852                	sd	s4,16(sp)
    10fa:	e456                	sd	s5,8(sp)
    10fc:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    10fe:	8a4e                	mv	s4,s3
    1100:	0009871b          	sext.w	a4,s3
    1104:	6685                	lui	a3,0x1
    1106:	00d77363          	bgeu	a4,a3,110c <malloc+0x44>
    110a:	6a05                	lui	s4,0x1
    110c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1110:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1114:	00001917          	auipc	s2,0x1
    1118:	efc90913          	addi	s2,s2,-260 # 2010 <freep>
  if(p == (char*)-1)
    111c:	5afd                	li	s5,-1
    111e:	a081                	j	115e <malloc+0x96>
    1120:	f04a                	sd	s2,32(sp)
    1122:	e852                	sd	s4,16(sp)
    1124:	e456                	sd	s5,8(sp)
    1126:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1128:	00001797          	auipc	a5,0x1
    112c:	f6078793          	addi	a5,a5,-160 # 2088 <base>
    1130:	00001717          	auipc	a4,0x1
    1134:	eef73023          	sd	a5,-288(a4) # 2010 <freep>
    1138:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    113a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    113e:	b7c1                	j	10fe <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1140:	6398                	ld	a4,0(a5)
    1142:	e118                	sd	a4,0(a0)
    1144:	a8a9                	j	119e <malloc+0xd6>
  hp->s.size = nu;
    1146:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    114a:	0541                	addi	a0,a0,16
    114c:	efbff0ef          	jal	1046 <free>
  return freep;
    1150:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1154:	c12d                	beqz	a0,11b6 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1156:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1158:	4798                	lw	a4,8(a5)
    115a:	02977263          	bgeu	a4,s1,117e <malloc+0xb6>
    if(p == freep)
    115e:	00093703          	ld	a4,0(s2)
    1162:	853e                	mv	a0,a5
    1164:	fef719e3          	bne	a4,a5,1156 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    1168:	8552                	mv	a0,s4
    116a:	b1bff0ef          	jal	c84 <sbrk>
  if(p == (char*)-1)
    116e:	fd551ce3          	bne	a0,s5,1146 <malloc+0x7e>
        return 0;
    1172:	4501                	li	a0,0
    1174:	7902                	ld	s2,32(sp)
    1176:	6a42                	ld	s4,16(sp)
    1178:	6aa2                	ld	s5,8(sp)
    117a:	6b02                	ld	s6,0(sp)
    117c:	a03d                	j	11aa <malloc+0xe2>
    117e:	7902                	ld	s2,32(sp)
    1180:	6a42                	ld	s4,16(sp)
    1182:	6aa2                	ld	s5,8(sp)
    1184:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1186:	fae48de3          	beq	s1,a4,1140 <malloc+0x78>
        p->s.size -= nunits;
    118a:	4137073b          	subw	a4,a4,s3
    118e:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1190:	02071693          	slli	a3,a4,0x20
    1194:	01c6d713          	srli	a4,a3,0x1c
    1198:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    119a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    119e:	00001717          	auipc	a4,0x1
    11a2:	e6a73923          	sd	a0,-398(a4) # 2010 <freep>
      return (void*)(p + 1);
    11a6:	01078513          	addi	a0,a5,16
  }
}
    11aa:	70e2                	ld	ra,56(sp)
    11ac:	7442                	ld	s0,48(sp)
    11ae:	74a2                	ld	s1,40(sp)
    11b0:	69e2                	ld	s3,24(sp)
    11b2:	6121                	addi	sp,sp,64
    11b4:	8082                	ret
    11b6:	7902                	ld	s2,32(sp)
    11b8:	6a42                	ld	s4,16(sp)
    11ba:	6aa2                	ld	s5,8(sp)
    11bc:	6b02                	ld	s6,0(sp)
    11be:	b7f5                	j	11aa <malloc+0xe2>
