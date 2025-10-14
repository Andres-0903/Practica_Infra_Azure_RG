pipeline {
    agent any

    parameters {
        booleanParam(
            name: 'DESTRUIR',
            defaultValue: false,
            description: 'Marcar esta opción si deseas destruir la infraestructura existente en Azure'
        )
    }

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
                sh 'ls -la practica1'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('practica1') {
                    echo '🚀 Inicializando Terraform...'
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('practica1') {
                    echo '🧩 Validando configuración...'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('practica1') {
                    echo '🧠 Generando plan de ejecución...'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { return params.DESTRUIR == false }
            }
            steps {
                dir('practica1') {
                    input message: '🟢 ¿Deseas aplicar los cambios en Azure? (Esto desplegará recursos reales)'
                    sh 'terraform apply tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { return params.DESTRUIR == true }
            }
            steps {
                dir('practica1') {
                    input message: '⚠️ ¿Confirmas eliminar los recursos creados en Azure?'
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Proceso completado exitosamente.'
        }
        failure {
            echo '❌ Error durante la ejecución del pipeline.'
        }
        aborted {
            echo '⚠️ Pipeline cancelado por el usuario.'
        }
    }
}
