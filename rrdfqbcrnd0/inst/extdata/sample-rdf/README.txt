SPARQL snippets to find difference between two graphs.

Source for SPARQL code: http://stackoverflow.com/questions/17323636/comparing-sparql-graphs

select * where {
graph ?g { ?s ?p ?o }
}

select * where {
graph <http://example.org/copy> { ?s ?p ?o }
NOT EXISTS { graph <http://example.org/orig> { ?s ?p ?o } }
}

 
construct { ?s ?p ?o } where {
graph <http://example.org/copy> { ?s ?p ?o }
NOT EXISTS { graph <http://example.org/orig> { ?s ?p ?o } }
}

When using fuseki with configuration fuseki-config-example-without-blank-nodes.ttl the later gives:

<http://example.org/ns#averageBMI>
        a       <http://purl.org/linked-data/cube#MeasureProperty> , <http://www.w3.org/1999/02/22-rdf-syntax-ns#Property> ;
        <http://www.w3.org/2000/01/rdf-schema#label>
                "average BMI"@en ;
        <http://www.w3.org/2000/01/rdf-schema#range>
                <http://www.w3.org/2001/XMLSchema#decimal> ;
        <http://www.w3.org/2000/01/rdf-schema#subPropertyOf>
                <http://purl.org/linked-data/sdmx/2009/measure#obsValue> .

<http://example.org/ns#o11>
        <http://example.org/ns#averageBMI>
                26.0 .

<http://example.org/ns#dsd-le3>
        <http://purl.org/linked-data/cube#component>
                <http://example.org/ns#measBMI> .

<http://example.org/ns#measBMI>
        <http://purl.org/linked-data/cube#measure>
                <http://example.org/ns#averageBMI> .
