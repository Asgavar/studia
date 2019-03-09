#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include <readline/readline.h>
#include <readline/history.h>

#define DELIMITERS " \t"

void lexify(char* user_input, char* buffer[]) {
  char* next_token;
  short token_idx = 1;

  /* ścieżka do programu */
  buffer[0] = strtok(user_input, DELIMITERS);

  while (next_token = strtok(NULL, DELIMITERS)) {
    buffer[token_idx] = next_token;
    ++token_idx;
  }
}

int run_the_new_process(char* progname, char* input_buffer[], char* envp[]) {
  return execve(progname, input_buffer, envp);
}

int main(int argc, char* argv[], char* envp[]) {
  char* user_input;
  char* input_buffer[255];

  memset(input_buffer, 0, 255 * sizeof(char*));

  do {
    user_input = readline(">> ");
    add_history(user_input);
    lexify(user_input, input_buffer);

    pid_t pid = fork();
    wait(0);

    if (pid == 0) {  /* czyli jesteśmy dzieckiem */
      int waserr = run_the_new_process(input_buffer[0], input_buffer, envp);

      if (waserr != 0) {
        printf("kod błędu: %d\n", errno);
      }
    }

  } while (strcmp(user_input, "exit"));

  return 0;
}
