pipeline {
    agent any
    
    environment {
        ARM_CLIENT_ID_Dev = credentials('ARM_CLIENT_ID_Dev') // ID de la App(Service Principal)
        ARM_CLIENT_SECRET_Dev = credentials('ARM_CLIENT_SECRET_Dev') // Secreto del SP
        ARM_TENANT_ID_Dev = credentials('ARM_TENANT_ID_Dev') // Tenant ID
        ARM_SUBSCRIPTION_ID_Dev = credentials('ARM_SUBSCRIPTION_ID_Dev') // Subscription ID
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
        
        stage('Ver credenciales') {
            steps {
                sh '''
                echo "ARM_CLIENT_ID_Dev: $ARM_CLIENT_ID_Dev"
                echo "ARM_CLIENT_SECRET_Dev(oculto por seguridad): ${#ARM_CLIENT_SECRET_Dev}"
                '''
            }
        }
        
        stage('Ver variables') {
            steps {
                sh '''
                echo "TENANT: $ARM_TENANT_ID_Dev"
                echo "SUBSCRIPTION: $ARM_SUBSCRIPTION_ID_Dev"
                echo "CLIENT ID: $ARM_CLIENT_ID_Dev"
                if [ -z "$ARM_CLIENT_SECRET_Dev" ]; then
                echo "❌ El ARM_CLIENT_SECRET_Dev está vacío"
                else
                echo "✅ El ARM_CLIENT_SECRET_Dev tiene contenido(oculto por seguridad)"
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
                    -backend-config="access_key=$ARM_CLIENT_SECRET_Dev"
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
        // always {
        //     echo '🧹 Limpiando workspace...'
        //     cleanWs()
        // }
        success {
            echo '✅ Pipeline ejecutado con éxito.'
        }
        failure {
            echo '❌ Error en la ejecución del pipeline.'
        }
    }
}