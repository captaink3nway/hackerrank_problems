#include <bits/stdc++.h>
using namespace std;

#define fastio() ios_base::sync_with_stdio(false);cin.tie(NULL)

#define lo(n) for(int i=0;i<n;i++)
#define fo(k,n) for(int i=k;i<n;i++)
#define lo1(n) for(int i=1;i<=n;i++)

#define ll long long
#define deb(x) cout << #x << "=" << x << endl

#define si(x)	scanf("%d",&x)
#define sl(x)	scanf("%lld",&x)
#define ss(s)	scanf("%s",s)

#define pi(x)	printf("%d\n",x)
#define pl(x)	printf("%lld\n",x)
#define ps(s)	printf("%s\n",s)

typedef vector<int>		vi;
typedef vector<ll>		vl;
typedef pair<int, int>	pii;
typedef pair<ll, ll>	pl;
typedef vector<pii>		vpii;
typedef vector<pl>		vpl;
typedef vector<vi>		vvi;
typedef vector<vl>		vvl;

#define pb push_back
#define mp make_pair

#define F first
#define S second

#define all(x) x.begin(), x.end()
#define clr(x) memset(x, 0, sizeof(x))
#define sortall(x) sort(all(x))

long long C(ll int n,ll int r) {
    if(r > n - r) r = n - r; 
    long long ans = 1;
    int i;

    for(i = 1; i <= r; i++) {
        ans *= n - r + i;
        ans /= i;
    }

    return ans;
}

void solve(){
    ll int n;
    sl(n);
    ll int a=0;
    ll int ans=1;
    ll int sum=(n*(n+1))/2;
    if(sum%2 !=0) ans=0;
    else if(n==3) ans=2;
    else{
        ll int partial_sum=0;
        for(ll int i=n;i>=1;i--){
            partial_sum+=i;
            if(partial_sum >= (sum/2)){
                if(partial_sum==(sum/2)) ans+=(C(n-ans,2)+C(ans,2));
                break;
            }
            else ans++;
        }
    }
    cout<<ans<<endl;
}

int main() {
    ll int t;
    sl(t);
	while(t--)
	    solve();
	return 0;
}