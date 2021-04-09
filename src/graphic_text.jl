using DataStructures, ViewerGL, LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
import Base.cat

View = ViewerGL.view

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
julia> ascii_LAR[46]
([2.0 2.0 … 1.5 2.0; 0.0 0.5 … 0.0 0.0], Array{Int64,1}[[1, 2], [2, 3], [3, 4], [4, 5]])

julia> ascii_LAR[126]
([1.0 1.75 2.75 3.5; 5.0 5.5 5.0 5.5], Array{Int64,1}[[1, 2], [2, 3], [3, 4]])
```
"""
ascii_LAR = DataStructures.OrderedDict(zip(32:126,hpcs))



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
julia> collect("PLaSM or LAR?")
13-element Vector{Char}:
 'P': ASCII/Unicode U+0050 (category Lu: Letter, uppercase)
 'L': ASCII/Unicode U+004C (category Lu: Letter, uppercase)
 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
 'S': ASCII/Unicode U+0053 (category Lu: Letter, uppercase)
 'M': ASCII/Unicode U+004D (category Lu: Letter, uppercase)
 ' ': ASCII/Unicode U+0020 (category Zs: Separator, space)
 'o': ASCII/Unicode U+006F (category Ll: Letter, lowercase)
 'r': ASCII/Unicode U+0072 (category Ll: Letter, lowercase)
 ' ': ASCII/Unicode U+0020 (category Zs: Separator, space)
 'L': ASCII/Unicode U+004C (category Lu: Letter, uppercase)
 'A': ASCII/Unicode U+0041 (category Lu: Letter, uppercase)
 'R': ASCII/Unicode U+0052 (category Lu: Letter, uppercase)
 '?': ASCII/Unicode U+003F (category Po: Punctuation, other)
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
julia> model = ViewerGL.text("PLaSM");
julia> @show model;
model = ([0.0 0.0 0.125 0.16666667 0.16666667 0.125 0.0 0.375 0.20833333 0.20833333 0.58333333 0.54166667 0.45833333 0.41666667 0.41666667 0.45833333 0.54166667 0.58333333 0.58333333 0.58333333 0.625 0.66666667 0.75 0.79166667 0.79166667 0.75 0.66666667 0.625 0.625 0.66666667 0.75 0.79166667 0.83333333 0.83333333 0.91666667 1.0 1.0; 0.0 0.25 0.25 0.20833333 0.125 0.08333333 0.08333333 0.0 0.0 0.25 0.04166667 0.0 0.0 0.04166667 0.08333333 0.125 0.125 0.08333333 0.0 0.125 0.04166667 0.0 0.0 0.04166667 0.08333333 0.125 0.125 0.16666667 0.20833333 0.25 0.25 0.20833333 0.0 0.25 0.16666667 0.25 0.0; 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0], [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6], [6, 7], [8, 9], [9, 10], [11, 12], [12, 13], [13, 14], [14, 15], [15, 16], [16, 17], [17, 18], [18, 11], [19, 20], [21, 22], [22, 23], [23, 24], [24, 25], [25, 26], [26, 27], [27, 28], [28, 29], [29, 30], [30, 31], [31, 32], [33, 34], [34, 35], [35, 36], [36, 37]])

julia> ViewerGL.view(model)
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
function Cat(args)
	return reduce( (x,y) -> append!(x,y), args; init=[] )
end




"""
	textWithAttributes(textalignment='centre', textangle=0,
		textwidth=1.0, textheight=2.0, textspacing=0.25)(strand::String)::LAR

Partial implementation of the GKS's graphics primitive `text`.

# Example

```
ViewerGL.view(ViewerGL.textWithAttributes("left", pi/4)("PLaSM"))
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
