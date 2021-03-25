// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
// total = 32 * 256 = 8192 words / register to fill 
// while(1) {
    // if (KEY is pressed) {
    //     blacken_screen
    // }
    // else {
    //     clear_screen
    // }
// }

// check the KBD status

(LOOP)
    @8191
    D=A // D = 8191, total pixel # need to colour
    @count
    M=D // count = 8191 (8191, 8190, 8189,...,3,2,1,0, total 8192)

// listen to the keyboard
    @KBD
    D=M

    @CLEAR
    D; JEQ


(BLACKEN)
    // if count < 0 , stop blacken the screen
    @count
    D=M
    @LOOP
    D; JLT
    // else, keep blacken the screen
    // the pixel to black  = M[SCREEN + count]
    @position
    M=D // M[position] = count

    @SCREEN
    D=A 
    @position
    AD=M+D // D=count+screen
    M=-1 // blacken M[count+screen]

    @count
    M=M-1
    @BLACKEN // always jum
    0;JMP


(CLEAR)
    @count 
    D=M
    @LOOP
    D; JLT // if count < 0, go to listenser, otherwise keep clear the screen

    @position
    M=D
    @SCREEN
    D=A
    @position
    AD=M+D
    M=0

    @count
    M=M-1
    @CLEAR
    0;JMP

// infinite loop 
@LOOP
0;JMP



