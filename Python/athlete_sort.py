def athleteSort(arr,k):
    for i in range(1, len(arr)):
        keyList = arr[i] 
        key = keyList[k]
        j = i-1
        while j >=0 and key < arr[j][k] : 
                arr[j+1]= arr[j] 
                j -= 1
        arr[j+1] = keyList
    for i in range (0, len(arr)):
        print (' '.join(list(map(str,(arr[i])))))

if __name__ == '__main__':
    nm = input().split()

    n = int(nm[0])

    m = int(nm[1])                                                                          


    arr = []

    for _ in range(n):
        arr.append(list(map(int, input().rstrip().split())))

    k = int(input())
    athleteSort(arr, k)