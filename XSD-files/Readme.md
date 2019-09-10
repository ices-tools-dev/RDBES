This folder contain a XSD files for each hierarchy, it can be used for the CSV format. The RDBES data exchange format is comma separated values CSV files (NOT XML files). But until we have a document describing the format it is suggested to use the XSD files.
The following describe how to use the XSD files.
Determine which hierarchy that should be used for the sample data. 
Open the equivalent XSD file e.g. H2.xsd and look for the word 'element' then the name="[xy]". Then the 'complexType name="[xy]"' will describe which data line/record that shoud come after looking at the 'element' then the name="[zt]" etc.
The fields in each data line/record can be found in the 'BaseTypes.xsd'.
