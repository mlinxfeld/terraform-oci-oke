resource "oci_core_vcn" "FoggyKitchenVCN" {
  cidr_block     = var.VCN-CIDR
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenVCN"
}

resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenInternetGateway"
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
}

resource "oci_core_route_table" "FoggyKitchenRouteTableViaIGW" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_vcn.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenRouteTableViaIGW"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id =  oci_core_internet_gateway.FoggyKitchenInternetGateway.id
  }
}

resource "oci_core_security_list" "FoggyKitchenOKESecurityList" {
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "FoggyKitchenOKESecurityList"
    vcn_id = oci_core_vcn.FoggyKitchenVCN.id
    
    egress_security_rules {
        protocol = "All"
        destination = "0.0.0.0/0"
    }

    /* This entry is necesary for DNS resolving (open UDP traffic). */
    ingress_security_rules {
        protocol = "17"
        source = var.VCN-CIDR
    }
}

resource "oci_core_subnet" "FoggyKitchenClusterSubnet1" {
  availability_domain = var.ADs[0]
  cidr_block          = "10.0.1.0/24"
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id              = oci_core_vcn.FoggyKitchenVCN.id
  display_name        = "FoggyKitchenClusterSubnet1"

  security_list_ids = [oci_core_vcn.FoggyKitchenVCN.default_security_list_id, oci_core_security_list.FoggyKitchenOKESecurityList.id]
  route_table_id    = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
}

resource "oci_core_subnet" "FoggyKitchenClusterSubnet2" {
  availability_domain = var.ADs[1]
  cidr_block          = "10.0.2.0/24"
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id              = oci_core_vcn.FoggyKitchenVCN.id
  display_name        = "FoggyKitchenClusterSubnet2"

  security_list_ids = [oci_core_vcn.FoggyKitchenVCN.default_security_list_id, oci_core_security_list.FoggyKitchenOKESecurityList.id]
  route_table_id    = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
}

resource "oci_core_subnet" "FoggyKitchenNodePoolSubnet1" {
  availability_domain = var.ADs[0]
  cidr_block          = "10.0.3.0/24"
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id              = oci_core_vcn.FoggyKitchenVCN.id
  display_name        = "FoggyKitchenNodePoolSubnet1"

  security_list_ids = [oci_core_vcn.FoggyKitchenVCN.default_security_list_id, oci_core_security_list.FoggyKitchenOKESecurityList.id]
  route_table_id    = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
}

resource "oci_core_subnet" "FoggyKitchenNodePoolSubnet2" {
  availability_domain = var.ADs[1]
  cidr_block          = "10.0.4.0/24"
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id              = oci_core_vcn.FoggyKitchenVCN.id
  display_name        = "FoggyKitchenNodePoolSubnet2"

  security_list_ids = [oci_core_vcn.FoggyKitchenVCN.default_security_list_id, oci_core_security_list.FoggyKitchenOKESecurityList.id]
  route_table_id    = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
}
