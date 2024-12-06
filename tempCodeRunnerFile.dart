#include <iostream>
#include <vector>
#include <deque>

using namespace std;

long long countPairs(const deque<int>& dq) {
    long long count = 0;
    int n = dq.size();
    for(int i = 0; i < n; i++) {
        for(int j = i + 1; j < n; j++) {
            if(dq[i] > 2LL * dq[j]) {
                count++;
            }
        }
    }
    return count;
}

void generateDeques(int index, vector<int>& arr, int remainingFront, int remainingBack,
                   deque<int>& currentDeque, long long& maxPairs) {
    int n = arr.size();
    
    // Base case: if we've processed all elements
    if(index == n) {
        maxPairs = max(maxPairs, countPairs(currentDeque));
        return;
    }
    
    // Try adding to front if we still have front insertions available
    if(remainingFront > 0) {
        currentDeque.push_front(arr[index]);
        generateDeques(index + 1, arr, remainingFront - 1, remainingBack, 
                      currentDeque, maxPairs);
        currentDeque.pop_front();
    }
    
    // Try adding to back if we still have back insertions available
    if(remainingBack > 0) {
        currentDeque.push_back(arr[index]);
        generateDeques(index + 1, arr, remainingFront, remainingBack - 1, 
                      currentDeque, maxPairs);
        currentDeque.pop_back();
    }
}

long long maxPairsInDeque(vector<int>& arr, int M, int K) {
    long long maxPairs = 0;
    deque<int> currentDeque;
    
    // Try all possible combinations of M front and K back insertions
    generateDeques(0, arr, M, K, currentDeque, maxPairs);
    
    return maxPairs;
}

int main() {
    int n, M, K;
    cin >> n >> M >> K;
    
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    
    cout << maxPairsInDeque(arr, M, K) << endl;
    
    return 0;
}