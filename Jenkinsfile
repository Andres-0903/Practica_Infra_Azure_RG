pipeline {
    agent any
    
    environment {
        // Mapeo de credenciales de Jenkins a variables que Terraform reconoce
        ARM_CLIENT_ID = credentials('ARM_CLIENT_ID_Dev')
        ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET_Dev')
        ARM_TENANT_ID = credentials('ARM_TENANT_ID_Dev')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID_Dev')
    }
    
    parameters {
        choice(
        name: 'ACTION',
        choices: ['plan', 'apply'],
        description: 'Selecciona la acción de Terraform(plan o apply)'
        )
        booleanParam(
        name: 'DESTRUIR',
        defaultValue: false,
        description: 'Marcar esta opción si deseas destruir la infraestructura en Azure'
        )
    }
    
    stages {
        stage('Checkout del repositorio') {
            steps {
                echo '📦 Clonando repositorio...'
                checkout scm
            }
        }
        
        stage('Validar credenciales') {
            steps {
                sh '''
                if [ -z "$ARM_CLIENT_ID" ] || [ -z "$ARM_CLIENT_SECRET" ] || [ -z "$ARM_TENANT_ID" ] || [ -z "$ARM_SUBSCRIPTION_ID" ]; then
                echo "❌ Alguna credencial está vacía. Abortando..."
                exit 1
                else
                echo "✅ Todas las credenciales están configuradas(ocultas por seguridad)"
                fi
                '''
            }
        }
        
        stage('Inicializar Terraform') {
            steps {
                echo '🚀 Inicializando Terraform...'
                dir('Infra_Azure') {
                    sh '''
                    terraform init \
                    -backend-config="resource_group_name=Practica_Terraform" \
                    -backend-config="storage_account_name=tfstatedvstorageacct" \
                    -backend-config="container_name=tfstate" \
                    -backend-config="key=infra.tfstate"
                    -migrate-state \
                    -input=false
                    '''
                }
            }
        }
        
        stage('Ejecutar acción de Terraform') {
            steps {
                dir('Infra_Azure') {
                    script {
                        if (params.DESTRUIR) {
                            echo '🔥 Destruyendo infraestructura en Azure...'
                            sh 'terraform destroy -auto-approve'
                        }else if (params.ACTION == 'plan') {
                            echo '🧭 Ejecutando Terraform plan...'
                            sh 'terraform plan -out=tfplan'
                        }else if (params.ACTION == 'apply') {
                            echo '🚀 Aplicando cambios con Terraform apply...'
                            sh '''
                            if [ -f tfplan ]; then
                            terraform apply -auto-approve tfplan
                            else
                            terraform apply -auto-approve
                            fi
                            '''
                        }
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo '✅ Pipeline ejecutado con éxito.'
        }
        failure {
            echo '❌ Error en la ejecución del pipeline.'
        }
    }
}