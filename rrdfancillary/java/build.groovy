def ant = new AntBuilder()

ant.mkdir(dir:"bin")
ant.javac(
  srcdir:"src", destdir:"bin",
  includes:"**/*.java",
  fork:"true") {
  classpath {
    fileset dir: "../inst/java", {
      include name: "*.jar"
    }
//    fileset dir: "../../rrdflibs/inst/java", {
    fileset dir: "../../../../packages/rrdf/rrdflibs/inst/java", {
      include name: "*.jar"
    }
  }
}

ant.jar(
  destfile:"../inst/java/rrdfancillary.jar",
  basedir:"bin",
  includes:"**/*.class"
)
