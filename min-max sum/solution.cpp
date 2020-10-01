#include <bits/stdc++.h>

using namespace std;

vector<string> split_string(string);

long minSum(vector<int> arr){
    long sum=0;
    for(int i=0;i<arr.size()-1;i++){
    sum=sum+arr[i];
    }
    return sum;
}
long maxSum(vector<int> arr){
    long sum=0;
    for(int i=1;i<arr.size();i++)
    sum=sum+arr[i];
    return sum;
}

// Complete the miniMaxSum function below.
void miniMaxSum(vector<int> arr) {
    int t;
    for(int i=0;i<arr.size()-1;i++){
        for(int j=0;j<arr.size()-1;j++){
            if(arr[j]>arr[j+1])
            {
                t=arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=t;
            }
        }
    }
    
    cout<<minSum(arr)<<" "<<maxSum(arr);

}

int main()
{
    string arr_temp_temp;
    getline(cin, arr_temp_temp);

    vector<string> arr_temp = split_string(arr_temp_temp);

    vector<int> arr(5);

    for (int i = 0; i < 5; i++) {
        int arr_item = stoi(arr_temp[i]);

        arr[i] = arr_item;
    }

    miniMaxSum(arr);

    return 0;
}

vector<string> split_string(string input_string) {
    string::iterator new_end = unique(input_string.begin(), input_string.end(), [] (const char &x, const char &y) {
        return x == y and x == ' ';
    });

    input_string.erase(new_end, input_string.end());

    while (input_string[input_string.length() - 1] == ' ') {
        input_string.pop_back();
    }

    vector<string> splits;
    char delimiter = ' ';

    size_t i = 0;
    size_t pos = input_string.find(delimiter);

    while (pos != string::npos) {
        splits.push_back(input_string.substr(i, pos - i));

        i = pos + 1;
        pos = input_string.find(delimiter, i);
    }

    splits.push_back(input_string.substr(i, min(pos, input_string.length()) - i + 1));

    return splits;
}
