# Phase 1: Type and property closure
# http://www.w3.org/TR/vocab-data-cube/#normalize-algorithm

PREFIX rdf:            <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX qb:             <http://purl.org/linked-data/cube#>

INSERT {
    ?o rdf:type qb:Observation .
} WHERE {
    [] qb:observation ?o .
};

INSERT {
    ?o  rdf:type qb:Observation .
    ?ds rdf:type qb:DataSet .
} WHERE {
    ?o qb:dataSet ?ds .
};

INSERT {
    ?s rdf:type qb:Slice .
} WHERE {
    [] qb:slice ?s.
};

INSERT {
    ?cs qb:componentProperty ?p .
    ?p  rdf:type qb:DimensionProperty .
} WHERE {
    ?cs qb:dimension ?p .
};

INSERT {
    ?cs qb:componentProperty ?p .
    ?p  rdf:type qb:MeasureProperty .
} WHERE {
    ?cs qb:measure ?p .
};

INSERT {
    ?cs qb:componentProperty ?p .
    ?p  rdf:type qb:AttributeProperty .
} WHERE {
    ?cs qb:attribute ?p .
}
