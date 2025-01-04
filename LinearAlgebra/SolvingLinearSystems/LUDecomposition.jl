function BackSubstitution(A::Matrix{Float64}, b::Vector{Float64})
    n = length(b)
    X = zeros(n)
    rows, cols = size(A)
    # check if the matrix is nxn
    if rows != cols
        println("The matrix is not square.")
    end
    # make sure that vector b is of the same length as A
    if n != rows || n != cols
        println("Vector b does not have appropriate length.")
    end
    # calculate the last element of the vector X
    X[n] = b[n]/A[rows,cols]
    # calculate the remaining elements of X

    for i in n-1:-1:1
        sum = 0.0
        for j in i+1:n
            sum = sum + A[i, j]*X[j]
        end
        X[i] = (b[i]-sum)/A[i,i]
    end
return X
end

A = Float64[-3 1 -2; 0 6 2; 0 0 -4]
b = Float64[15, 22, 4]

x = BackSubstitution(A,b)
println(x)

function ForwardSubstitution(A::Matrix, b::Vector)
    n = length(b)
    X = zeros(n)
    rows, cols = size(A)
    # check if the matrix is nxn
    if rows != cols
        println("The matrix is not square.")
    end
    # make sure that vector b is of the same length as A
    if n != rows || n != cols
        println("Vector b does not have appropriate length.")
    end
    # calculate the first element of X vector
    X[1] = b[1]/A[1,1]
    for i in 2:1:n
        sum = 0.0
        for j in 1:i-1
            sum = sum + A[i,j]*X[j]
        end 
        X[i] = (b[i] -sum)/A[i,i] 
    end
    return X
end

A = [2 0 0; 2 -3 0; 1 -1 4]
b = [18, 3, 12]

ForwardSubstitution(A,b)

function LUDecomposition(A::Matrix)
    U = copy(A)
    rows, cols = size(U)
    if rows != cols
        println("The matrix is not square.")
        return 0
    end
    # initiate an identity matrix
     L = zeros(rows, cols)
    for i in 1:rows
        for j in 1:cols
            L[i,i] = 1
        end
    end
    for i in 1:rows
        pivot = U[i,i]
        for j in i+1:rows
            factor = U[j,i]/pivot
            L[j,i] = factor
            for k in i:cols
                U[j,k] = U[j,k] - factor*U[i,k]
            end
        end
    end
    return L,U 
end

# A = [2 3 4; 4 5 10; 4 8 2]
A = Float64[50050 50 0; 50 380 -1; 50000 330 0]
L , U = LUDecomposition(A)

# now we can use functions to solve liner systems
b = Float64[5.7, 10, 5]
z = ForwardSubstitution(L, b)
x = BackSubstitution(U,z)
println(x)