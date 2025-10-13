pipeline {
    agent any

    environment {
        ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
        ARM_TENANT_ID       = credentials('ARM_TENANT_ID')
    }

    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                echo '📦 Clonando el repositorio...'
                git branch: 'pruebas', url: 'https://github.com/Andres-0903/Practica_Infra_Azure_RG.git'
            }
        }

        stage('Verificar archivos') {
            steps {
                echo '📂 Mostrando archivos descargados...'
                sh 'pwd'
                sh 'ls -la'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.WORKSPACE}") {   // 👈 ejecuta dentro del workspace del repo
                    echo '🚀 Inicializando Terraform...'
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${env.WORKSPACE}") {
                    echo '🧩 Validando configuración...'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${env.WORKSPACE}") {
                    echo '🧠 Generando plan de ejecución...'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: '¿Deseas aplicar los cambios en Azure?'
                dir("${env.WORKSPACE}") {
                    echo '💥 Aplicando cambios...'
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Despliegue completado correctamente.'
        }
        failure {
            echo '⚠️ Error durante el despliegue.'
        }
    }
}
