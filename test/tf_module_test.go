package test

import (
	"fmt"
	"math/rand"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestTerraformBasicExample(t *testing.T) {
	t.Parallel()

	clusterName := fmt.Sprintf("test-cluster-%d", rand.Intn(10000))
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// website::tag::1::Set the path to the Terraform code that will be tested.
		// The path to where our Terraform code is located
		// TerraformDir: "../examples/terraform-basic-example",
		TerraformDir: "./",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"name": clusterName,
			"extra_port_mappings": []map[string]interface{}{
				{
					"host_port":      30300,
					"container_port": 12344,
					"protocol":       "TCP",
				},
				{
					"host_port":      30301,
					"container_port": 12345,
					"protocol":       "TCP",
				},
			},
		},

		// Variables to pass to our Terraform code using -var-file options
		// VarFiles: []string{"varfile.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: false,
	})

	// website::tag::4::Clean up resources with "terraform destroy". Using "defer" runs the command at the end of the test, whether the test succeeds or fails.
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2::Run "terraform init" and "terraform apply".
	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	// actualTextExample := terraform.Output(t, terraformOptions, "name")

	// website::tag::3::Check the output against expected values.
	// Verify we're getting back the outputs we expect
	// assert.Equal(t, expectedText, actualTextExample)
}
