A = [6 -1 1;0 13 -16; 0 8 -11]
function TransposeMatrix(A::Matrix)
    rows, cols = size(A)
    result = zeros(Int64, cols, rows)
    for i in 1:rows
        for j in 1:cols
            result[i,j] = A[j,i]
        end
    end
    return result
end
function MultiplyMatrixVector(A::Matrix, x::Vector)
    rowsA, colsB = size(A)
    lenx = length(x)
    result = zeros(Float64, rowsA)
    if colsB==lenx
        for i in 1:rowsA
            for j in 1:lenx
            result[i] += A[i,j]*x[j]
            end
        end
    else println("Impossible to multiply.")
    end
    return result
end



# A = [-3.35 -3.00 -3.60; 1.20 2.05 -6.20; -3.60 -2.40 3.85]
# x = [12.5, -12.5, 6.25]
A = [6 -1 1;0 13 -16; 0 8 -11]
x = [10.5, 21.0, 10.5]
transA = TransposeMatrix(A)
b = MultiplyMatrixVector(transA, x)

function getR(b::Vector, x::Vector)
lenb = length(b)
lenx = length(x)
r = zeros(Float64, lenb)
scalar=0
if lenb == lenx
    for i in 1:lenb
        r[i] = b[i]/x[i]
    end
    scalar = r[1]
    for i in 2:lenb
        if r[i] != scalar
            println("Inconsistent scalar factors.")
        end
    end
end
return r, scalar
end
getR(b, x)
