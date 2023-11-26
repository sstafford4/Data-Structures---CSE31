#include <stdio.h>

int main(){
    int userNum = 0;
    int errorLine = 0; 
    
    printf ("Enter the number of repetitions for the punishment phrase: ");
    scanf("%d", &userNum);
    if (userNum < 1){
        while (userNum < 1){
            printf("You entered an invalid value for the number of repetitions!\n");
            printf ("Enter the number of repetitions for the punishment phrase again: ");
            scanf("%d", &userNum);
        }
    }

    printf("\n");
    printf ("Enter the line where you wish to introduce the typo: ");
    scanf("%d", &errorLine);
    if (errorLine < 1){
        while (errorLine < 1){
            printf("You entered an invalid value for the typo placement!\n");
            printf ("Enter the line where you wish to introduce the typo again: ");
            scanf("%d", &errorLine);
        }
    }

    printf("\n");
    if (userNum > 0 && errorLine > 0){
        for (int i = 1; i < userNum+1; i++){
            if (i != errorLine){
                printf("Coding is fun and interesting!\n");
            }
            else if (i = errorLine){
                printf("Coding is fun end intreseting!\n");
            }
        }
    }
}