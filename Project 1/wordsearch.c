#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// Work Log: 03/05/2023
    // It can print the 2d array of letters
    // Working on converting everything to uppercase/ getting a count of whether or not the word can be found from the list of letters.
    // Gonna take a break to work on some calc homework, but I think I've made some pretty good progress. 

    // I understand how the program is supposed to work, so that will help a lot in the future. 

// Work Log: 03/11/2023
    // Currently getting a segmentation fault, not looking too bad though.
    // I'll figure out where its stemming from soon. 

// Work Log: 03/11/2023
    // it semi works? Some words arent found when they should be :/
    // I'll sort out the kinks. 

//Work Log: 03/14/2023
    // I honestly am ot sure why it doesnt work for every word, but I am satisfied with what I can do
    // the words that it works for are seemingly random.
    // I think it has something to do with my loops. When testing the word rat for puzzle2, it found it twice and showed both paths. 
    // 

// Words that work:
    // Puzzle 1: hello, web, aoba, 
    // Puzzle 2: banana, anana, rat,
    // Puzzle 3: hi, deter, 



// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
void printPuzzle(char** arr);
void searchPuzzle(char** arr, char* word);
int bSize;

int** fWordArr; 
int wordCount = 0; // the word count
int wordLen = 0; // the length of the word
int fWord = 0; // found word


// Main function, DO NOT MODIFY 	
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
        return 2;
    }
    int i, j;
    FILE *fptr;

    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }

    // Read the size of the puzzle block
    fscanf(fptr, "%d\n", &bSize);
    
    // Allocate space for the puzzle block and the word to be searched
    char **block = (char**)malloc(bSize * sizeof(char*));
    char *word = (char*)malloc(20 * sizeof(char));

    // Read puzzle block into 2D arrays
    for(i = 0; i < bSize; i++) {
        *(block + i) = (char*)malloc(bSize * sizeof(char));
        for (j = 0; j < bSize - 1; ++j) {
            fscanf(fptr, "%c ", *(block + i) + j);            
        }
        fscanf(fptr, "%c \n", *(block + i) + j);
    }
    fclose(fptr);

    printf("Enter the word to search: ");
    scanf("%s", word);
    
    // Print out original puzzle grid
    printf("\nPrinting puzzle before search:\n");
    printPuzzle(block);
    
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
    
    return 0;
}

void printPuzzle(char** arr) {
	// This function will print out the puzzle grid from the desired txt file.  
    for (int i = 0; i < bSize; i++){
        for (int j = 0; j < bSize; j++){
            printf("%c ", *(*(arr + i) + j));
            //printf("%d", bSize); // This is to confirm the value of bSize. 
        }
        printf("\n");
    }
    printf("\n");
}

// this prints out the 2d integer array
void printInt(int** arr){
    for (int i = 0; i < bSize; i++){
		for(int j = 0; j < bSize; j++){
			printf("%d      ", *(*(arr + i) + j));
		}
		printf("\n");
	}
    printf("\n\n");
}

int truePuzzle(char** Arr, char* word, int row, int col){
    wordLen = strlen(word); // make sure that youre looking at the first element in the string.

    if (wordCount == 0){
        for (int i = 0; i < bSize; i++){// these loops go through the 2d array searching for the first character. 
            for (int j = 0;  j < bSize; j++){
                if (*(*(Arr + i) + j) == *(word + wordCount)){
                    wordCount += 1;
                    // Now, using recursion to check if the next character is touched by the first one that was found. 
                    if ((truePuzzle(Arr, word, i, j)) != -1){
                        // if you get to this point, then recursion was successful and now the final element is equal to itself + 10* the character location.
                        *(*(fWordArr + i) + j) = *(*(fWordArr + i) + j) * 10 + wordCount;
                        wordCount -= 1;
                        fWord = 1;
                    }
                } 
            }
        }
    }
    // If the character isnt the first element, start searching through the array within the correct range. 
    else {
        // search in a 3x3 radius around the letter that you found. 
        for (int i = (row - 1); i <= (row + 1); i++){
            for (int j = (col - 1);  j <= (col + 1); j++){
                if (wordCount >= wordLen){
                    return 1;// if the final letter is found, then the program worked.
                }
                if (i >= 0 && i < bSize && j >= 0 && j < bSize && !(i == row && j == col)){
                    // Now we gotta check if this is even the element we want
                    if (*(*(Arr + i) + j) == *(word + wordCount)){
                        // if it is, then make the wordCount counter go up.
                        wordCount += 1;
                        // Now more recursion!! but reverse what we wanted last time.
                        if ((truePuzzle(Arr, word, i, j)) != -1){
                            *(*(fWordArr + i) + j) = *(*(fWordArr + i) + j) * 10 + wordCount;
                            wordCount -= 1;
                            return 1;
                        }
                        
                    }
                }  
            }
        }
    }
    // this resets it to look for another path.
    wordCount -= 1;
    return -1;
}

// this function is hopefully going to convert any lowercase letters to uppercase. 
// this should make it so my counter picks up on any lowercase letters in the word given by the user. 
char convertUpper(char* word, int length){
    for (int i = 0; i < length + 1; i++){
        if (*(word + i) >= 'a' && *(word + 1) <= 'z'){
            *(word + i) = *(word + i) - 32; 
        }
    }
    return *(word);
}

void searchPuzzle(char** arr, char* word) {
    // This function checks if arr contains the search word. If the 
    // word appears in arr, it will print out a message and the path 
    // as shown in the sample runs. If not found, it will print a 
    // different message as shown in the sample runs.

    fWordArr = (int**)malloc(bSize * sizeof(int*));
    //fill fWordArr with 0s
    for (int i = 0; i < bSize; i++){
            *(fWordArr + i) = (int*)malloc(bSize * sizeof(int));
            for (int j = 0; j < bSize; j++){
                *(*(fWordArr + i) + j) = 0;
            }
    }
    
    convertUpper(word, strlen(word));

    truePuzzle(arr, word, 0, 0); 

    if (fWord == 1){
        printf("Word Found!\n");
        printf("Printing the search path: \n");
        printInt(fWordArr);
    }
    else{
        printf("Word not found! \n");
    }

}