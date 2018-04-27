/*********************************************
 * OPL 12.8.0.0 Model
 * Author: yansenxu
 * Creation Date: Apr 24, 2018 at 2:06:56 PM
 *********************************************/
int NbNodes = ...; //number of nodes in substrate network;
range Nodes = 1..NbNodes;
{int} NodeSet = asSet( Nodes );
tuple Edge {
	int u;
	int v;
//	int capacity;
};

{Edge} Edges = ...;
int Capacity[Edges] = ...;
tuple Path {
	int src;
	int dst;
	{int} nodes;
};


{Path} Paths= ...;
int DeltaEP[Edges][Paths] = ...; 



execute{

}

tuple SFC {
	int s;
	int d;
	int t;
	int o;
	int NbVNFs;
	{int} bw;
	{int} vnf;
}

int NbSFC = ...; //number of nodes in substrate network;
SFC SFCRequests[1..NbSFC] = ...;

//dvar int+ z[i in 1..NbSFC][v in Nodes] in 1..SFCRequests[i].NbSFC;
tuple DvarNode {
	int i;
	int j;
	int k;
};
tuple DvarEdge {
	int i;
	int j;
	int k;
};
{DvarNode} dvarNodeSet = {<i,j,k> | i in 1..NbSFC, j in 1..SFCRequests[i].NbVNFs, k in Nodes};
{DvarEdge} dvarEdgeSet = {<i,j,k> | i in 1..NbSFC, j in 1..SFCRequests[i].NbVNFs, k in 1..NbNodes*NbNodes};
dvar boolean z[s in dvarNodeSet];
dvar boolean w[s in dvarEdgeSet];

execute
{
	writeln("Nodes:  ", NodeSet);  
// writeln("Edges:  ", Edges);
	for(var e in Edges){
		for(var p in Paths){
			writeln("DeltaEP", e,p);
			writeln("DeltaEP: ", DeltaEP[e][p]);		
		}	
	}
// writeln("DeltaEP:  ", DeltaEP[<1, 2>][<1, 2, {1, 2}>]);
// writeln("SFCRequests:  ", SFCRequests);
};

/*
P: Set of pre-calculated paths in G(V,E). 
– pu,v: Set of K shortest paths between u and v in G(V,E), where u, v ∈ V and pu,v ⊂ P.
– π: A path in ?, s(π) and d(π) represent the source and destination of π, respectively, and len(π) denotes the hop-count of π.
– δe,π : A boolean constant to indicate whether a path
π uses a link e.Ifyes,wehave δe,π = 1, and 0 otherwise.
*/

