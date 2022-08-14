

//#include <bits/stdc++.h>
#include <vector>
#include <string>
#include <iostream>
#include <list>
#include <map>
#include <queue>
#include <fstream>
#include <unordered_set>

using namespace std;


int orangesRotting(vector<vector<int>>& grid) {
    
    // track fresh + store first rottens
    int freshes = 0, minutes = 0;
    vector<pair<size_t,size_t>> rotten;
    for (size_t i = 0; i < grid.size(); ++i) {
        for (size_t j = 0; j < grid[i].size(); ++j) {
            if (grid[i][j] == 2) rotten.push_back({ i, j });
            else if (grid[i][j] == 1) ++freshes;
        }
    }
    
    // calculate number of minutes
    vector<int> dirs = {0,1,0,-1,0};
    while (!rotten.empty() && freshes > 0) {
        auto [row, col] = rotten.back();
        rotten.pop_back();
        bool didRot = false;
        
        for (size_t i = 0; i < 4; ++i) {
            int nRow = row + dirs[i], nCol = col + dirs[i + 1];
            if (nRow < 0 || nCol < 0 ||
                nRow >= grid.size() || nCol >= grid[0].size()) continue;
            if (grid[nRow][nCol] == 1) {
                // make it rotten, add it to the array, reduce freshes
                --freshes;
                grid[nRow][nCol] = 2;
                rotten.push_back({ nRow, nCol });
                didRot = true;
            }
        }
        if (didRot) ++minutes;
        cout << boolalpha << row << ' ' << col << ' ' << didRot << ' ' << rotten.size() << ' ' << minutes << endl;
    }
    
    return freshes ? -1 : minutes;
}

int main() {
    vector<vector<int>> x = { {2,1,1},{1,1,0},{0,1,1} };
    orangesRotting(x);
}
