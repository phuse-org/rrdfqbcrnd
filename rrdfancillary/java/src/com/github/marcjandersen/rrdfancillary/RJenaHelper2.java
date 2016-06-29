
package com.github.marcjandersen.rrdfancillary;

import com.hp.hpl.jena.rdf.model.Model;

// from apache-jena-2.13.0/src-examples/arq/examples/update/UpdateExecuteOperations.java
// import org.apache.jena.atlas.lib.StrUtils ;
// import org.apache.jena.riot.Lang ;
// import org.apache.jena.riot.RDFDataMgr ;

// import com.hp.hpl.jena.sparql.sse.SSE ;
import com.hp.hpl.jena.update.* ;

public class RJenaHelper2 {

    // patterned after sparql and construct in RJenaHelper2
    // https://jena.apache.org/documentation/query/update.html
    // http://stackoverflow.com/questions/6981467/jena-arq-difference-between-model-graph-and-dataset
    // This is version 3.0.x:
    // https://github.com/apache/jena/blob/master/jena-arq/src-examples/arq/examples/update/UpdateProgrammatic.java

    // note RRDF uses jena 2.12 - DatasetFactory is a 3.0 method
    // use examples from version 2.13 ...
    // /opt/apache-jena-2.13.0/src-examples/arq/examples/update/UpdateExecuteOperations.java
    // same pattern as code for construct and saveRdf
    // ~/packages/rrdf/rrdf/java/src/com/github/egonw/rrdf/RJenaHelper.java
       
  public static void sparqlUpdate(Model model, String updateString) throws Exception {
          UpdateRequest request = UpdateFactory.create() ;
          UpdateFactory.parse(request, updateString);
	  try {
	      UpdateAction.execute(request, model ) ;
	  } finally {
	      //
	  }
  }

}

