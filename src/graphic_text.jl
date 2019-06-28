using DataStructures
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
import Base.cat

View = Plasm.view

# Graphic text font implementation
# Vector definition of printable ASCII codes as one-dimensional LAR models.
# Font design from *Geometric Programming for Computer-Aided Design*, Wiley, 2003.

ascii32 = ([0.0; 0.0],Array{Int64,1}[[1]])
ascii33 = ([1.75 1.75 2.0 2.0 1.5 1.5; 1.75 5.5 0.5 1.0 1.0 0.5],Array{Int64,1}[[1,2],[3,4],[4,5],[5,6],[6,3]])
ascii34 = ([1.0 2.0 2.0 2.0 1.5 1.5 2.0 3.0 3.0 3.0 2.5 2.5; 4.0 5.0 5.5 6.0 6.0 5.5 4.0 5.0 5.5 6.0 6.0 5.5],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,3],[7,8],[8,9],[9,10],[10,11],[11,12],[12,9]])
ascii35 = ([1.0 3.0 1.0 3.0 1.25 1.75 2.25 2.75; 2.5 2.5 3.5 3.5 1.75 4.0 1.75 4.0],Array{Int64,1}[[1,2],[3,4],[5,6],[7,8]])
ascii36 = ([0.0 1.0 3.0 4.0 4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 2.0 2.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 4.0 5.0 6.0 6.0 5.0 -0.5 6.5],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11],[11,12],[13,14]])
ascii37 = ([2.5 2.5 2.0 2.0 2.5 2.5 2.0 2.0 1.5 3.5; 0.0 0.5 0.5 0.0 5.5 6.0 6.0 5.5 5.5 11.5],Array{Int64,1}[[1,2],[2,3],[3,4],[4,1],[5,6],[6,7],[7,8],[8,5],[9,10]])
ascii38 = ([4.0 3.0 1.0 0.0 0.0 1.0 2.0 3.0 3.0 2.0 1.0 1.0 3.0 4.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 4.0 5.0 6.0 5.0 4.0 2.0 2.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11],[11,12],[12,13],[13,14]])
ascii39 = ([1.0 2.0 2.0 2.0 1.5 1.5; 4.0 5.0 5.5 6.0 6.0 5.5],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,3]])
ascii40 = ([2.0 1.0 0.5 1.0 2.0; 0.0 1.0 3.0 5.0 6.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5]])
ascii41 = ([2.0 3.0 3.5 3.0 2.0; 0.0 1.0 3.0 5.0 6.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5]])
ascii42 = ([1.0 3.0 2.0 2.0 1.0 3.0 1.0 3.0; 3.0 3.0 2.0 4.0 2.0 4.0 4.0 2.0],Array{Int64,1}[[1,2],[3,4],[5,6],[7,8]])
ascii43 = ([1.0 3.0 2.0 2.0; 3.0 3.0 2.0 4.0],Array{Int64,1}[[1,2],[3,4]])
ascii44 = ([1.0 2.0 2.0 2.0 1.5 1.5; -1.0 0.0 0.5 1.0 1.0 0.5],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,3]])
ascii45 = ([1.0 3.0; 3.0 3.0],Array{Int64,1}[[1,2]])
ascii46 = ([2.0 2.0 1.5 1.5 2.0; 0.0 0.5 0.5 0.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5]])
ascii47 = ([1.0 3.0; 0.0 6.0],Array{Int64,1}[[1,2]])
ascii48 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0; 1.0 0.0 0.0 1.0 5.0 6.0 6.0 5.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,1],[4,8]])
ascii49 = ([0.0 2.0 2.0 0.0 4.0; 4.0 6.0 0.0 0.0 0.0],Array{Int64,1}[[1,2],[2,3],[4,5]])
ascii50 = ([0.0 0.0 1.0 3.0 4.0 4.0 0.0 4.0; 4.0 5.0 6.0 6.0 5.0 4.0 0.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8]])
ascii51 = ([0.0 4.0 2.0 4.0 4.0 3.0 1.0 0.0 0.0; 6.0 6.0 4.0 2.0 1.0 0.0 0.0 1.0 2.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9]])
ascii52 = ([4.0 0.0 4.0 4.0; 1.0 1.0 6.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4]])
ascii53 = ([4.0 0.0 0.0 3.0 4.0 4.0 3.0 1.0 0.0 0.0; 6.0 6.0 4.0 4.0 3.0 1.0 0.0 0.0 1.0 2.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10]])
ascii54 = ([4.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0 3.0 1.0 0.0; 6.0 6.0 5.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0 3.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11]])
ascii55 = ([0.0 0.0 4.0 0.0; 5.0 6.0 6.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4]])
ascii56 = ([1.0 3.0 4.0 4.0 3.0 1.0 0.0 0.0 4.0 4.0 3.0 1.0 0.0 0.0; 0.0 0.0 1.0 2.0 3.0 3.0 2.0 1.0 4.0 5.0 6.0 6.0 5.0 4.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,1],[6,5],[5,9],[9,10],[10,11],[11,12],[12,13],[13,14],[14,6]])
ascii57 = ([0.0 3.0 4.0 4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0; 0.0 0.0 1.0 5.0 6.0 6.0 5.0 3.0 2.0 2.0 3.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11]])
ascii58 = ([2.0 2.0 1.5 1.5 2.0 2.0 1.5 1.5; 1.0 1.5 1.5 1.0 3.0 3.5 3.5 3.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,1],[5,6],[6,7],[7,8],[8,5]])
ascii59 = ([2.0 2.0 1.5 1.5 1.0 2.0 2.0 2.0 1.5 1.5; 3.0 3.5 3.5 3.0 -0.5 0.5 1.0 1.5 1.5 1.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,1],[5,6],[6,7],[7,8],[8,9],[9,10],[10,7]])
ascii60 = ([3.0 0.0 3.0; 6.0 3.0 0.0],Array{Int64,1}[[1,2],[2,3]])
ascii61 = ([1.0 3.0 1.0 3.0; 2.5 2.5 3.5 3.5],Array{Int64,1}[[1,2],[3,4]])
ascii62 = ([1.0 4.0 1.0; 6.0 3.0 0.0],Array{Int64,1}[[1,2],[2,3]])
ascii63 = ([2.0 2.0 1.5 1.5 1.75 1.75 3.0 3.0 2.0 1.0 0.0 0.0; 0.0 0.5 0.5 0.0 1.0 2.75 4.0 5.0 6.0 6.0 5.0 4.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,1],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11],[11,12]])
ascii64 = ([4.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0 2.0 1.0 2.0 3.0 2.0; 0.0 0.0 1.0 3.0 4.0 4.0 3.0 1.0 1.0 2.0 3.0 2.0 1.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11],[11,12],[12,13]])
ascii65 = ([0.0 0.0 1.0 3.0 4.0 4.0 0.0 4.0; 0.0 5.0 6.0 6.0 5.0 0.0 2.0 2.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[7,8]])
ascii66 = ([0.0 0.0 3.0 4.0 4.0 3.0 4.0 4.0 3.0 0.0 0.0 3.0; 0.0 6.0 6.0 5.0 4.0 3.0 2.0 1.0 0.0 0.0 3.0 3.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[11,12]])
ascii67 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0; 1.0 0.0 0.0 1.0 5.0 6.0 6.0 5.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8]])
ascii68 = ([0.0 0.0 3.0 4.0 4.0 3.0 0.0; 0.0 6.0 6.0 5.0 1.0 0.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]])
ascii69 = ([4.0 0.0 0.0 4.0 0.0 3.0; 0.0 0.0 6.0 6.0 3.0 3.0],Array{Int64,1}[[1,2],[2,3],[3,4],[5,6]])
ascii70 = ([0.0 0.0 4.0 0.0 3.0; 0.0 6.0 6.0 3.0 3.0],Array{Int64,1}[[1,2],[2,3],[4,5]])
ascii71 = ([2.0 4.0 4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0; 3.0 3.0 1.0 0.0 0.0 1.0 5.0 6.0 6.0 5.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10]])
ascii72 = ([0.0 0.0 4.0 4.0 0.0 4.0; 0.0 6.0 6.0 0.0 3.0 3.0],Array{Int64,1}[[1,2],[3,4],[5,6]])
ascii73 = ([2.0 2.0 1.0 3.0 1.0 3.0; 0.0 6.0 0.0 0.0 6.0 6.0],Array{Int64,1}[[1,2],[3,4],[5,6]])
ascii74 = ([0.0 1.0 2.0 3.0 3.0 2.0 4.0; 1.0 0.0 0.0 1.0 6.0 6.0 6.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[6,7]])
ascii75 = ([4.0 0.0 4.0 0.0 0.0; 6.0 3.0 0.0 0.0 6.0],Array{Int64,1}[[1,2],[2,3],[4,5]])
ascii76 = ([4.0 0.0 0.0; 0.0 0.0 6.0],Array{Int64,1}[[1,2],[2,3]])
ascii77 = ([0.0 0.0 2.0 4.0 4.0; 0.0 6.0 4.0 6.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5]])
ascii78 = ([0.0 0.0 4.0 4.0 4.0; 0.0 6.0 2.0 0.0 6.0],Array{Int64,1}[[1,2],[2,3],[4,5]])
ascii79 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0; 1.0 0.0 0.0 1.0 5.0 6.0 6.0 5.0 1.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9]])
ascii80 = ([0.0 0.0 3.0 4.0 4.0 3.0 0.0; 0.0 6.0 6.0 5.0 3.0 2.0 2.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]])
ascii81 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0 3.0 4.0; 1.0 0.0 0.0 1.0 5.0 6.0 6.0 5.0 1.0 1.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[10,11]])
ascii82 = ([0.0 0.0 3.0 4.0 4.0 3.0 0.0 3.0 4.0; 0.0 6.0 6.0 5.0 3.0 2.0 2.0 2.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[8,9]])
ascii83 = ([0.0 1.0 3.0 4.0 4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 4.0 5.0 6.0 6.0 5.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9],[9,10],[10,11],[11,12]])
ascii84 = ([2.0 2.0 0.0 4.0; 0.0 6.0 6.0 6.0],Array{Int64,1}[[1,2],[3,4]])
ascii85 = ([0.0 0.0 1.0 3.0 4.0 4.0; 6.0 1.0 0.0 0.0 1.0 6.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6]])
ascii86 = ([0.0 2.0 4.0; 6.0 0.0 6.0],Array{Int64,1}[[1,2],[2,3]])
ascii87 = ([0.0 0.0 1.0 2.0 3.0 4.0 4.0; 6.0 3.0 0.0 3.0 0.0 3.0 6.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]])
ascii88 = ([0.0 4.0 0.0 4.0; 0.0 6.0 6.0 0.0],Array{Int64,1}[[1,2],[3,4]])
ascii89 = ([0.0 2.0 4.0 2.0 2.0; 6.0 2.0 6.0 2.0 0.0],Array{Int64,1}[[1,2],[2,3],[4,5]])
ascii90 = ([0.0 4.0 0.0 4.0; 6.0 6.0 0.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4]])
ascii91 = ([2.0 1.0 1.0 2.0; 0.0 0.0 6.0 6.0],Array{Int64,1}[[1,2],[2,3],[3,4]])
ascii92 = ([1.0 3.0; 6.0 0.0],Array{Int64,1}[[1,2]])
ascii93 = ([2.0 3.0 3.0 2.0; 0.0 0.0 6.0 6.0],Array{Int64,1}[[1,2],[2,3],[3,4]])
ascii94 = ([1.0 2.0 3.0; 5.0 6.0 5.0],Array{Int64,1}[[1,2],[2,3]])
ascii95 = ([1.0 4.0; 0.0 0.0],Array{Int64,1}[[1,2]])
ascii96 = ([2.0 2.0 3.0 2.5 2.5 2.0; 4.5 5.0 6.0 4.0 4.5 4.0],Array{Int64,1}[[1,2],[2,3],[4,5],[5,1],[1,6],[6,4]])
ascii97 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0 4.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 2.0 0.0 3.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,1],[9,10]])
ascii98 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 0.0 0.0 1.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 2.0 0.0 5.0 5.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,1],[9,10],[10,11]])
ascii99 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 2.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8]])
ascii100 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0 4.0 3.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 2.0 0.0 5.0 5.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,1],[9,10],[10,11]])
ascii101 = ([4.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0 0.0; 0.0 0.0 1.0 2.0 3.0 3.0 2.0 1.0 1.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9]])
ascii102 = ([4.0 4.0 3.0 2.0 1.0 1.0 0.0 2.0; 3.0 4.0 5.0 5.0 4.0 0.0 1.0 1.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[7,8]])
ascii103 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0 3.0 1.0 0.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 2.0 0.0 -1.0 -1.0 0.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,1],[1,9],[9,10],[10,11],[11,12]])
ascii104 = ([4.0 4.0 3.0 1.0 0.0 0.0 0.0 1.0; 0.0 2.0 3.0 3.0 2.0 0.0 5.0 5.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[6,7],[7,8]])
ascii105 = ([1.0 3.0 1.0 3.0 2.0 2.0 2.25 2.25 1.75 1.75; 0.0 0.0 3.0 3.0 0.0 3.0 3.75 4.25 4.25 3.75],Array{Int64,1}[[1,2],[3,4],[5,6],[7,8],[8,9],[9,10],[10,7]])
ascii106 = ([1.0 3.0 2.0 2.0 1.0 0.0 2.25 2.25 1.75 1.75; 3.0 3.0 3.0 0.0 -1.0 0.0 3.75 4.25 4.25 3.75],Array{Int64,1}[[1,2],[3,4],[4,5],[5,6],[7,8],[8,9],[9,10],[10,7]])
ascii107 = ([0.0 1.0 1.0 0.0 4.0 2.0 1.0 3.0 4.0; 0.0 0.0 3.0 3.0 0.0 0.0 1.0 3.0 3.0],Array{Int64,1}[[1,2],[2,3],[3,4],[5,6],[6,7],[7,8],[8,9]])
ascii108 = ([2.0 2.0 1.0 1.0 3.0; 0.0 5.0 5.0 0.0 0.0],Array{Int64,1}[[1,2],[2,3],[4,5]])
ascii109 = ([4.0 4.0 2.0 2.0 2.0 0.0 0.0 0.0; 0.0 3.0 2.0 0.0 3.0 2.0 0.0 3.0],Array{Int64,1}[[1,2],[2,3],[4,5],[5,6],[7,8]])
ascii110 = ([3.0 3.0 1.0 1.0 1.0; 0.0 3.0 2.0 0.0 3.0],Array{Int64,1}[[1,2],[2,3],[4,5]])
ascii111 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 2.0 1.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,9]])
ascii112 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 0.0 0.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 2.0 3.0 -1.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,1],[9,10]])
ascii113 = ([4.0 3.0 1.0 0.0 0.0 1.0 3.0 4.0 4.0 4.0; 1.0 0.0 0.0 1.0 2.0 3.0 3.0 2.0 3.0 -1.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8],[8,1],[9,10]])
ascii114 = ([0.0 2.0 1.0 1.0 1.0 2.0 3.0 4.0; 0.0 0.0 0.0 3.0 2.0 3.0 3.0 2.0],Array{Int64,1}[[1,2],[3,4],[5,6],[6,7],[7,8]])
ascii115 = ([0.0 4.0 3.0 1.0 0.0 1.0 3.0 4.0; 0.0 0.0 1.0 1.0 2.0 3.0 3.0 2.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,8]])
ascii116 = ([1.0 3.0 2.0 2.0 2.0 3.0; 0.0 0.0 0.0 5.0 4.0 4.0],Array{Int64,1}[[1,2],[3,4],[5,6]])
ascii117 = ([0.0 1.0 1.0 2.0 3.0 4.0 4.0; 3.0 3.0 1.0 0.0 0.0 1.0 3.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]])
ascii118 = ([0.0 1.0 3.0 4.0; 3.0 0.0 3.0 3.0],Array{Int64,1}[[1,2],[2,3],[3,4]])
ascii119 = ([0.0 0.0 1.0 2.0 3.0 4.0 4.0; 3.0 2.0 0.0 2.0 0.0 2.0 3.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]])
ascii120 = ([0.0 1.0 4.0 1.0 4.0; 3.0 3.0 0.0 0.0 3.0],Array{Int64,1}[[1,2],[2,3],[4,5]])
ascii121 = ([0.0 1.0 2.5 0.0 1.0 4.0; 3.0 3.0 1.5 0.0 0.0 3.0],Array{Int64,1}[[1,2],[2,3],[4,5],[5,6]])
ascii122 = ([0.0 0.0 3.0 0.0 3.0 4.0; 2.0 3.0 3.0 0.0 0.0 1.0],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6]])
ascii123 = ([2.5 2.0 2.0 1.5 2.0 2.0 2.5; 6.5 6.0 3.5 3.0 2.5 0.0 -0.5],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]])
ascii124 = ([2.0 2.0; 0.0 5.0],Array{Int64,1}[[1,2]])
ascii125 = ([1.5 2.0 2.0 2.5 2.0 2.0 1.5; 6.5 6.0 3.5 3.0 2.5 0.0 -0.5],Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]])
ascii126 = ([1.0 1.75 2.75 3.5; 5.0 5.5 5.0 5.5],Array{Int64,1}[[1,2],[2,3],[3,4]])


"""
	hpcs::Array


"""
hpcs = [
	ascii32,ascii33,ascii34,ascii35,ascii36,ascii37,ascii38,ascii39,ascii40,ascii41,
	ascii42,ascii43,ascii44,ascii45,ascii46,ascii47,ascii48,ascii49,ascii50,ascii51,
	ascii52,ascii53,ascii54,ascii55,ascii56,ascii57,ascii58,ascii59,ascii60,ascii61,
	ascii62,ascii63,ascii64,ascii65,ascii66,ascii67,ascii68,ascii69,ascii70,ascii71,
	ascii72,ascii73,ascii74,ascii75,ascii76,ascii77,ascii78,ascii79,ascii80,ascii81,
	ascii82,ascii83,ascii84,ascii85,ascii86,ascii87,ascii88,ascii89,ascii90,ascii91,
	ascii92,ascii93,ascii94,ascii95,ascii96,ascii97,ascii98,ascii99,ascii100,ascii101,
	ascii102,ascii103,ascii104,ascii105,ascii106,ascii107,ascii108,ascii109,ascii110,ascii111,
	ascii112,ascii113,ascii114,ascii115,ascii116,ascii117,ascii118,ascii119,ascii120,ascii121,
	ascii122,ascii123,ascii124,ascii125,ascii126 ]


"""
ascii_LAR = DataStructures.OrderedDict{Int,Lar.LAR}()

	ascii_LAR::{Int,Lar.LAR}

*Ordered dictionary* of printable ASCII codes as one-dimensional *LAR models* in 2D.

`Key` is the `integer` ASCII code between 32 and 126.
Font design: *Geometric Programming for Computer-Aided Design*, Wiley, 2003.
# Example
```
julia> Plasm.ascii_LAR[46]
([2.0 2.0 … 1.5 2.0; 0.0 0.5 … 0.0 0.0], Array{Int64,1}[[1, 2], [2, 3], [3, 4], [4, 5]])

julia> Plasm.ascii_LAR[126]
([1.0 1.75 2.75 3.5; 5.0 5.5 5.0 5.5], Array{Int64,1}[[1, 2], [2, 3], [3, 4]])
```
"""
ascii_LAR = DataStructures.OrderedDict(zip(32:126,Plasm.hpcs))



# Attributes for `text` 2D graphics primitive.
# Reference to GKS ISO Graphics Standard (ISO/IEC 7942-4:1998)

global textalignment = "centre" #default value
global textangle = pi/4 #default value
global textwidth = 1.0 #default value
global textheight = 1.0 #default value
global textspacing = 0.25 #default value
global fontwidth = 4.0 #default value
global fontheight = 8.0 #default value
global fontspacing = 1.0 #default value


"""
	charpols(mystring::String)::Array{LAR,1}

Return the `array` of `LAR` models, for chars in `mystring`.
"""
function charpols(mystring)
    return [ascii_LAR[code] for code in [Int(char) for char in mystring]]
end



"""
	charseq(mystring::String)::Array{Char,1}

# Example
```
julia> Plasm.charseq("PLaSM")
5-element Array{Char,1}:
 'P'
 'L'
 'a'
 'S'
 'M'
```
"""
function charseq(mystring)
	return [char for char in mystring]
end


"""
	text(mystring::String)::LAR

Compute the one-dim *LAR model* drawing the contents of `mystring`

# Example
```
julia> model = Plasm.text("PLaSM")
# output
([0.0 0.0 3.0 4.0 4.0 3.0 0.0 9.0 5.0 5.0 14.0 13.0 11.0 10.0
10.0 11.0 13.0 14.0 14.0 14.0 15.0 16.0 18.0 19.0 19.0 18.0 16.0 15.0 15.0 16.0 18.0
19.0 20.0 20.0 22.0 24.0 24.0; 0.0 6.0 6.0 5.0 3.0 2.0 2.0 0.0 0.0 6.0 1.0 0.0 0.0 1.0
2.0 3.0 3.0 2.0 0.0 3.0 1.0 0.0 0.0 1.0 2.0 3.0 3.0 4.0 5.0 6.0 6.0 5.0 0.0 6.0 4.0
6.0 0.0],
Array{Int64,1}[[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[8,9],[9,10],[11,12],[12,13],[13,14],
[14,15],[15,16],[16,17],[17,18],[18,11],[19,20],[21,22],[22,23],[23,24],[24,25],[25,26],
[26,27],[27,28],[28,29],[29,30],[30,31],[31,32],[33,34],[34,35],[35,36],[36,37]])

julia> Plasm.view(model)
```
"""
function text(mystring)
	out = comp([ Lar.struct2lar, Lar.Struct, cat, distr,
			cons([ charpols, k(Lar.t(fontspacing+fontwidth,0)) ]),charseq ])(mystring)
	return out
end



"""
	a2a(mat::Matrix)(models::Array{LAR,1})::Struct.body

Local function, service to `textWithAttributes` implementation.
"""
function a2a(mat)
	function a2a0(models)
		assembly = []
		for model in models
			push!( assembly, Lar.Struct([ mat,model ]) )
		end
		assembly
	end
	return a2a0
end


"""
	translate(c::Number)(lar::LAR)::LAR

Local function, service to `textWithAttributes` implementation.
"""
function translate(c)
	function translate0(lar)
		xs = lar[1][1,:]
		width = maximum(xs) - minimum(xs)
		apply(Lar.t(width/c,0))(lar)
	end
	return translate0
end


"""
	align(textalignment="centre"::String)(model::LAR)::LAR

Local function, service to `textWithAttributes` implementation.
"""
function align(textalignment="centre")
	function align1(model)
		if ( textalignment == "centre" ) out=translate(-2)(model)
		elseif ( textalignment == "right" ) out=translate(-1)(model)
		elseif ( textalignment == "left" ) out=model
		end
		return out
	end
end



"""
 	cat(args)

Redefined locally, as service to `textWithAttributes` implementation.
"""
function cat(args)
	return reduce( (x,y) -> append!(x,y), args; init=[] )
end




"""
	textWithAttributes(textalignment='centre', textangle=0,
		textwidth=1.0, textheight=2.0, textspacing=0.25)(strand::String)::LAR

Partial implementation of the GKS's graphics primitive `text`.

# Example

```
Plasm.view(Plasm.textWithAttributes("left", pi/4)("PLaSM"))
```
"""
function textWithAttributes(textalignment="centre", textangle=0,
							textwidth=1.0, textheight=2.0, textspacing=0.25)
	function textWithAttributes(strand)
		id = x->x
		mat = Lar.s(textwidth/fontwidth,textheight/fontheight)
		comp([
		   apply(Lar.r(textangle)),
		   align(textalignment),
		   Lar.struct2lar,
		   Lar.Struct,
		   cat,
		   distr,
		   cons([ a2a(mat) ∘ charpols,
				k(Lar.t(textwidth+textspacing,0)) ]),
		   charseq ])(strand)
	end
end


"""
	embed(n::Int)(model::LAR)::LAR

Embed a `LAR` `model` of dimension ``d`` in a space ``R^{d+n}``.
The embedding is done by adding ``d`` zero coordinates to each vertex.

# Example

```
julia> square = Lar.cuboid([1,1])
([0.0 0.0 1.0 1.0; 0.0 1.0 0.0 1.0], Array{Int64,1}[[1, 2, 3, 4]])

julia> Plasm.embed(1)(square)
([0.0 0.0 1.0 1.0; 0.0 1.0 0.0 1.0; 0.0 0.0 0.0 0.0], Array{Int64,1}[[1, 2, 3, 4]])
```
"""
function embed(n)
	function embed0( larmodel )
		return [larmodel[1]; zeros(n,size(larmodel[1],2))], larmodel[2]
	end
	return embed0
end


"""
	numbering(model::LARmodel)

Display a *wireframe* of `model` cells, of any dimension, with their *ordinal number*.
Different `colors` and size are used for the various dimensional cells.

# Examples

```
model = Lar.cuboidGrid([3,4,2], true)
Plasm.view(Plasm.numbering()(model))

model = Lar.cuboidGrid([10,10], true)
Plasm.view(Plasm.numbering(1.5)(model))
```
"""
function numbering(numberSizeScaling=1)
	p = PyCall.pyimport("pyplasm")
	function numbering0(model)
		V,cells = model
		if size(V,1)==2
			V = Plasm.embed(1)(model)[1]
		end
		wireframe = Plasm.lar2hpc(V,cells[2])
		ns = numberSizeScaling
		gcode = Plasm.textWithAttributes("centre", 0, 0.1ns, 0.2ns, 0.025ns)
		scene = [wireframe]
		for (h,skel) in enumerate(cells)
			  colors = [p["GREEN"], p["YELLOW"], p["CYAN"], p["ORANGE"]]
		 	  nums = []
			  for (k,cell) in enumerate(skel)
				center = sum([V[:,v] for v in cell])/length(cell)
				code = Plasm.embed(1)( gcode(string(k)) )
				scaling = (0.6+0.1h,0.6+0.1h,1)
				push!(nums, Lar.struct2lar( Lar.Struct([
					Lar.t(center...), Lar.s(scaling...), code ]) ))
			end
			hpc = Plasm.lar2hpc(nums)
			push!( scene, p["COLOR"](colors[h])(hpc) )
		end
		p["STRUCT"]( scene )
	end
	return numbering0
end



"""
#	numbering(scaling=0.1)
#		(V::Lar.Points, copEV::Lar.ChainOp, copFE::Lar.ChainOp)::Lar.Hpc

Produce the numbered `Hpc` of `planar_arrangement()` 2D output.
Vertices in `V` are stored by row.

# Example

```julia
using LinearAlgebraicRepresentation
using Plasm, SparseArrays
Lar = LinearAlgebraicRepresentation

V,EV = Lar.randomcuboids(7, 1.0);
V = Plasm.normalize(V,flag=true);
W = convert(Lar.Points, V');
cop_EV = Lar.coboundary_0(EV::Lar.Cells);
cop_EW = convert(Lar.ChainOp, cop_EV);
V, copEV, copFE = Lar.planar_arrangement(W, cop_EW);

Plasm.view( Plasm.numbering(0.05)((V, copEV, copFE)) )
```
"""
function numbering1(scaling=0.1)
	function numbering0(model::Tuple{Lar.Points,Lar.ChainOp,Lar.ChainOp})
		(V, copEV, copFE) = model
		VV = [[k] for k=1:size(V,1)]
		EV = [findnz(copEV[h,:])[1] for h=1:size(copEV,1)]
		FV = [collect(Set(cat(EV[e] for e in findnz(copFE[i,:])[1]))) for i=1:size(copFE,1)]
		FV = convert(Array{Array{Int64,1},1}, FV)
		model = (convert(Lar.Points, V'), Lar.Cells[VV,EV,FV])
		return Plasm.numbering(scaling)(model)
	end
	return numbering0
end
