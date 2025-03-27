### INSIEMI ###

set I;
set K;

### PARAMETRI ###

param N integer;
param n integer;
param f_iniziale{i in I} := Uniform(0,1);
param f{i in I} := f_iniziale[i] / sum{j in I} f_iniziale[j];
param M := max{i in I} f[i];

### VARIABILI ###

var g{i in I} >= 0;
var u{k in K} >= 0;
var z{i in I, k in K} binary;
var e{i in I} >= 0;
var t{i in I: i < N} binary;

### VINCOLI ###

subject to g_non_negativa{i in I}: g[i] >= 0;

subject to assegnazione{i in I}: sum{k in K} z[i,k] = 1;

subject to upper_bound_g{i in I, k in K}: g[i] <= u[k] + (1 - z[i,k]) * M;
subject to lower_bound_g{i in I, k in K}: g[i] >= u[k] - (1 - z[i,k]) * M;

subject to somma: sum{i in I} g[i] = 1;

subject to num_transizioni: sum{i in I: i < N} t[i] = n-1;
subject to def_transizione{i in 1..N-1, k in K}: z[i,k] - z[i+1,k] <= t[i];

subject to errore_positivo{i in I}: e[i] >= (f[i] - g[i]); 
subject to errore_negativo{i in I}: e[i] >= (g[i] - f[i]);

### OBIETTIVO ###

minimize errore_tot: sum{i in I} e[i];





