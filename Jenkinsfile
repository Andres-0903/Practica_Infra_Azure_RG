pipeline {
    agent any

    environment {
        // Variables de autenticación para Azure
        ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
        ARM_TENANT_ID       = credentials('ARM_TENANT_ID')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "📦 Clonando el repositorio..."
                git branch: 'pruebas', url: 'https://github.com/Andres-0903/Practica_Infra_Azure_RG.git'
            }
        }

        stage('Terraform Init') {
            steps {
                echo "🚀 Inicializando Terraform..."
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                echo "🧩 Validando configuración..."
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo "🧠 Generando plan de ejecución..."
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    def userInput = input(
                        message: "¿Deseas aplicar los cambios en Azure?",
                        parameters: [booleanParam(defaultValue: false, name: 'applyChanges')]
                    )
                    if (userInput) {
                        echo "✅ Aplicando los cambios..."
                        sh 'terraform apply -auto-approve tfplan'
                    } else {
                        echo "❌ Despliegue cancelado por el usuario."
                    }
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Despliegue completado exitosamente."
        }
        failure {
            echo "⚠️ Error durante el despliegue."
        }
    }
}
