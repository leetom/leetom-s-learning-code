#include<iostream>

using namespace std;

enum players
{
     Fred,
     Paul,
     Jim,
     Allen,
     playersCount   // count of players
};

int& scores( players challengers)
{
     static int scoreCard[playersCount];
     return scoreCard[challengers];
}

int main()
{
     scores(Fred)  = 5;
     scores(Paul)  = 10;
     scores(Jim)   = 15;
     scores(Allen) = 20;
     scores(Fred) ++;

     cout << scores(Fred)  << " " << endl;
     cout << scores(Paul)  << " " << endl;
     cout << scores(Jim)   << " " << endl;
     cout << scores(Allen) << " " << endl;

     return 0;
}
