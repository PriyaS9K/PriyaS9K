# Define the parameters
$organization = "your_organization"
$project = "your_project"
$pipelineId = 123 # Replace with your pipeline ID
$personalAccessToken = "your_pat" # Replace with your personal access token
$variableName = "your_variable_name"
$variableValue = "your_variable_value"

# Define the API URL
$url = "https://dev.azure.com/$organization/$project/_apis/pipelines/$pipelineId/runs?api-version=6.0-preview.1"

# Create the request body with the variable
$requestBody = @{
    "resources" = @{
        "repositories" = @{
            "self" = @{
                "refName" = "refs/heads/main" # Replace with your branch name
            }
        }
    }
    "variables" = @{
        "$variableName" = @{
            "value" = "$variableValue"
        }
    }
} | ConvertTo-Json -Depth 3

# Define the headers
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Basic $([Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$personalAccessToken")))"
}

# Trigger the pipeline
$response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $requestBody

# Output the response
$response | Format-List
