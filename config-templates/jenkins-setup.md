# Jenkins Setup Instructions

1. Run: `cd jenkins && docker-compose up -d`
2. Get initial password: `docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
3. Access: http://localhost:8080
4. Complete setup wizard
5. Install required plugins
