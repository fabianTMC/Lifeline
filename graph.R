library(RNeo4j)

graph = startGraph("http://localhost:7474/db/data/")

# Node with multiple labels and properties.
# node = createNode(graph, "Person", name = "Test Node")

# get the names and the ids
query = "MATCH n RETURN n.first_name,n.last_name,ID(n)"
nodes <- cypher(graph, query)

names <- c()

# generate the names from a data frame of nodes
for(i in 1:length(nodes)) {
  row <- nodes[i,]
  names <- c(names, paste(row$n.first_name, row$n.last_name, sep=' '))
}

# create a relationship between two different nodes
query = "MATCH (a:Person), (b:Person)
WHERE ID(a) = 60 AND ID(b) = 56
CREATE (a)-[r:Father]->(b)
RETURN r"

cypher(graph, query)