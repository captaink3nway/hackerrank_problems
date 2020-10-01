#include<bits/stdc++.h>
using namespace std;
typedef long long int ll;
ll h[100001];
ll power[100001];
ll p=31;
ll modulo=1e9 + 7;
void generatehash(string s)
{
    power[0]=1;
    h[0]=s[0]-'a' + 1;
    for(int i=1;i<s.size();i++)
    {
        power[i]=(power[i-1]*p)%modulo;
        h[i]= (h[i-1] + (((s[i]-'a'+1)%modulo)  *  (power[i]%modulo))%modulo ) % modulo;
    }

}
ll gethash(ll l, ll r)
{
    if(l==0) return h[r];
    else return ((h[r]-h[l-1]) + modulo) % modulo;
}
int main()
{
    int t;
    cin>>t;
    while(t--)
    {
        string s;
        cin>>s;
        generatehash(s);
        int count=0;
        int n=s.length();
        for(int i=1;i<n-1;i=i+2)
        {
            bool c1=(gethash(0,i/2)*(power[(i/2 + 1) - 0]))%modulo == gethash((i/2)+1, i);
            bool c2=(gethash(i+1,((n+i)/2))*power[ ((n+i)/2 + 1) - (i+1)]) %modulo == gethash((n+i)/2 + 1 , n-1);
            if(c1 && c2) count++; 
        }
        cout<<count<<endl;
    }
}