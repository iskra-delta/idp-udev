		;; gdp.s
        ;; 
        ;; thompson ef9367 graphics display processor consts. 
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 22.03.2022    tstih


        ;; --- 0x20 - W: command, R:the status register -----------------------     
        .equ	EF9367_CMD,             0x20    ; command register (W)
        .equ    EF9367_CMD_DMOD_SET,    0x00    ; select pen (set bit 1 of CR1)
        .equ    EF9367_CMD_DMOD_CLR,    0x01    ; select eraser (clr bit 1 of CR1)
        .equ    EF9367_CMD_PEN_DOWN,    0x02    ; pen/eraser down
        .equ    EF9367_CMD_PEN_UP,      0x03    ; pen/eraser up
        .equ    EF9367_CMD_CLS,         0x04    ; clear screen
        .equ    EF9367_CMD_00,          0x05    ; x=y=0
        .equ    EF9367_CMD_CLS00,       0x06    ; clear screen, x=y=0
        .equ    EF9367_CMD_CLEAR,       0x07    ; cls, CSIZE to min., all regs to 0
        .equ    EF9367_CMD_SCAN,        0x0c    ; screen scan
        .equ    EF9367_CMD_X0,          0x0d    ; x=0
        .equ    EF9367_CMD_Y0,          0x0e    ; y=0
        .equ    EF9367_CMD_DMEM,        0x0f    ; direct memory access 4 next cyc.


        ;; --- 0x21 - RW: control register, bit 7 is reserved (always 0) ------
        .equ    EF9367_CR1,             0x21
        .equ    EF9367_CR1_PEN_DOWN,    0x01    ; 1 pen down, 0 pen up
        .equ    EF9367_CR1_SET_PEN,     0x02    ; 1 pen, 0 eraser


        ;; --- 0x22 - RW: control register 2, bit 7-4 are not used ------------
        .equ    EF9367_CR2,             0x22
        ;; bits 1 and 2 are vector type
        .equ    EF9367_CR2_SOLID,       0b00    ; solid vector type


        ;; --- 0x23 - RW: character size --------------------------------------
        ;; low nibble is scaling on x, high nibble is scaling on y)
        .equ    EF9367_CH_SIZE,         0x23


        ;; --- 0x25 - RW: delta x ---------------------------------------------
        .equ    EF9367_DX,              0x25
        ;; --- 0x27 - RW: delta y ---------------------------------------------
        .equ    EF9367_DY,              0x27


        ;; --- 0x28 - RW: x pos hi --------------------------------------------
        .equ    EF9367_XPOS_HI,         0x28
        ;; --- 0x29 - RW: x pos low -------------------------------------------
        .equ    EF9367_XPOS_LO,         0x29
        ;; --- 0x2a - RW: y pos hi --------------------------------------------
        .equ    EF9367_YPOS_HI,         0x2a
        ;; --- 0x2b - RW: y pos low -------------------------------------------
        .equ    EF9367_YPOS_LO,         0x2b


        ;; --- 0x2f - R:the status (NI) register and its bitmask --------------
        .equ    EF9367_STS_NI,          0x2f    ; status reg. (no interrupt reset)
        .equ    EF9367_STS_NI_READY,    0x04    ; low when executing command


        ;; --- 0x30 - R/W:PIO gr. common register -----------------------------
        .equ    PIO_GR_CMN,             0x30