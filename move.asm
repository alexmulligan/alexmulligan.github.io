define color      $03
define background $00
define xMax       $20
define yMax       $04
define xPos       $e7
define yPos       $e8
define offset     $e9
define oldOffset  $ea
define multA      $fa
define multB      $fb
define multRes    $fc
define lastKey    $ff
define up         $77
define down       $73
define left       $61
define right      $64

  jsr init
  jmp loop

init:
  lda #$20  ; 
  sta multB ; - set one factor to 0x20 (pixels in one line)
  lda #$02 ; 
  sta xPos ; 
  sta yPos ; - set pos to (2,2)
  jsr getOffset
  jsr draw
  rts

loop:
  ldy offset
  sty oldOffset
  jsr changePos
  jsr draw
  jmp loop

changePos:
  ldx lastKey
  cpx #up
  beq upKey
  cpx #down
  beq downKey
  cpx #left
  beq leftKey
  cpx #right
  beq rightKey
  rts
upKey:
  dec yPos
  jmp changeEnd
downKey:
  inc yPos
  jmp changeEnd
leftKey:
  dec xPos
  jmp changeEnd
rightKey:
  inc xPos
changeEnd:
  ldx #$00
  stx lastKey
  jsr getOffset
  jsr erase
  rts

draw:
  ldy offset
  lda #color
  sta $0200,Y
  rts

erase:
  ldy oldOffset
  lda #background
  sta $0200,Y
  rts

getOffset:
  lda #$00
  ldy yPos
  sty multA
  jsr multiply
  lda multRes
  clc
  adc xPos
  sta offset
  rts

multiply: ; TODO: Check for zero before multiplying
  lda #$00
  ldy #$00
multLoop:
  iny
  adc multB
  cpy multA
  bne multLoop
  sta multRes
  lda #$00
  rts
