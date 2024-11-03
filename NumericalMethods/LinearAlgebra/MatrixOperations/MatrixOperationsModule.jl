module MatrixOperationsModule

function AddMatrices(A::Matrix, B::Matrix)
    rowsA, colsA = size(A)
    C = zeros(Int64, rows, cols)
    if size(A)==size(B)
        for i in 1:rowsA
            for j in 1:colsA 
            C[i,j] = A[i,j] + B[i,j]
            end
        end
        result = C
    else println("The sizes do not match.")
    end
    return result
end
function MatrixRaisedtoPower(A::Matrix, p::Int64)
    rowsA, colsA = size(A)
    if rowsA != colsA
        error("Matrix must be square.")
    end
    result = copy(A)
    C = zeros(eltype(A), rowsA, colsA)
    for k in 2:p
        for i in 1:rowsA
            for j in 1:colsA 
                for l in 1:rowsA
                C[i,j] += result[i,l]*A[l,j]
                end
            end
        end
        result = C
    end
    return result
end

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

function ScalarMultiplication(matrix::Matrix, c::Int64)
   rows, cols = size(matrix)
   result = zeros(Int64, rows, cols)
    for i in 1:rows 
        for j in 1:cols 
            result[i,j] = c * A[i,j]
        end
    end
    return result
end

function MultiplyMatrices(A::Matrix, B::Matrix)
    rowsA, colsA = size(A)
    rowsB, colsB = size(B)
    
    if colsA == rowsB
    result = zeros(Int64, rowsA, colsB)
    
    for i in 1:rowsA
        for j in 1:colsB
            for k in 1:colsA
                result[i, j] += A[i, k] * B[k, j]
            end
        end
    end
else println("Size do not match")
end
    return result
end
A = Float64[6 2 8; -3 4 1; 4 -4 5]
adjA = Float64[2 -7 -6; 1 -7 -3; -4 7 5]
result = MultiplyMatrices(A, adjA)
println(result)
function TransposeVector(A::Matrix)
    result = reshape(A, length(A), 1)
    return result
end
B = [1 1/2 1/3 1/4 1/5 1/6]


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

end

function InsertRow(A::Matrix, rowIndex::Int64, rowVector::Vector)
    rows, cols = size(A)
    result = copy(A)
    lenRow = length(rowVector)
    if rowIndex > (rows + 1) || rowIndex < 1
        error("Impossible to add row, pick a row index that is within or just above the last row.")
    end
    if lenRow != cols
        error("The length of the vector does not suit the number of columns.")
    end
    result = vcat(result[1:rowIndex-1, :], rowVector', result[rowIndex:end, :])
    return result
end

function InsertColumn(A::Matrix, colIndex::Int64, colVector::Vector)
    rows, cols = size(A)
    result = copy(A)
    lenCol = length(colVector)
    if colIndex > (cols + 1) || colIndex < 1
        error("Impossible to add column, pick a column index that is within or just after the last column.")
    end
    if lenCol != rows
        error("The length of the vector does not match the number of rows.")
    end
    result = hcat(result[:, 1:colIndex-1], colVector, result[:, colIndex:end])
    return result
end

function GetDiagonal(A::Matrix)
    rows, cols = size(A)
    result = 0
    diagonal = []
    for i in 1:rows
        for j in 1:cols
            if i==j
                result = A[i,j]
                push!(diagonal, result)
            end
        end
    end
    return diagonal
end

function GetUpperTriangular(A::Matrix)
    rows, cols = size(A)
    result = zeros(eltype(A), rows, cols)
    for i in 1:rows
        for j in 1:cols
            if j>i
                result[i,j] = A[i,j]
            end
        end
    end
    return result
end

function GetLowerTriangular(A::Matrix)
    rows, cols = size(A)
    result = zeros(eltype(A), rows, cols)
    for i in 1:rows
        for j in 1:cols
            if i>j
                result[i,j] = A[i,j]
            end
        end
    end
    return result
end

function GetInverse(A::Matrix)
    rows, cols = size(A)

end
A = [1 2 3; 4 5 6; 7 8 9]
inv(A)

function SwitchRows(A::Matrix, row1::Int64, row2::Int64)
    rows, cols = size(A)
    if row1>rows || row2>rows
        println("The row index exceeds the size of the matrix.")
    end
    temp = A[row1, :]
    A[row1, :] = A[row2, :]
    A[row2, :] = temp
    return A
    end