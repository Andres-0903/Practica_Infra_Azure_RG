pipeline {
    agent any

    environment {
        ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')        // ID de la App (Service Principal)
        ARM_CLIENT_SECRET    = credentials('ARM_CLIENT_SECRET')    // Secreto del SP
        ARM_TENANT_ID        = credentials('ARM_TENANT_ID')        // Tenant ID
        ARM_SUBSCRIPTION_ID  = credentials('ARM_SUBSCRIPTION_ID')  // Subscription ID
    }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply'],
            description: 'Selecciona la acción de Terraform (plan o apply)'
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
                echo 'Clonando repositorio...'
                checkout scm
            }
        }

        stage('Inicializar Terraform') {
            steps {
                echo 'Inicializando Terraform...'
                sh '''
                    terraform init \
                      -backend-config="access_key=$ARM_CLIENT_SECRET"
                '''
            }
        }

        stage('Ejecutar acción de Terraform') {
            steps {
                script {
                    if (params.DESTRUIR) {
                        echo '🔥 Destruyendo infraestructura en Azure...'
                        sh 'terraform destroy -auto-approve'

                    } else if (params.ACTION == 'plan') {
                        echo '🧭 Ejecutando Terraform plan...'
                        sh 'terraform plan -out=tfplan'

                    } else if (params.ACTION == 'apply') {
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

    post {
        always {
            echo '🧹 Limpiando workspace...'
            cleanWs()
        }
        success {
            echo '✅ Pipeline ejecutado con éxito.'
        }
        failure {
            echo '❌ Error en la ejecución del pipeline.'
        }
    }
}
