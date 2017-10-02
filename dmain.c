/* DUNGEON-- MAIN PROGRAM */

/*COPYRIGHT 1980, INFOCOM COMPUTERS AND COMMUNICATIONS, CAMBRIDGE MA. 02142*/
/* ALL RIGHTS RESERVED, COMMERCIAL USAGE STRICTLY PROHIBITED */
/* WRITTEN BY R. M. SUPNIK */

#define EXTERN
#define INIT

#include <emscripten.h>
#include "funcs.h"
#include "vars.h"

char * EMSCRIPTEN_KEEPALIVE get_input_buffer() {
    more_input();
    prsvec_1.prscon = 1;  // as if rdline_ had been called
    return input_1.inbuf;
}
