package com.abacorp.aba.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.cloud.aws.autoconfigure.context.ContextInstanceDataAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

/**
 *  Because caused by `EC2MetadataUtils : Unable to retrieve the requested metadata` (needless log trace)
 *  Add `@EnableAutoConfiguration` for 'exclude' options.
 */
@Configuration
@EnableAutoConfiguration(exclude = {ContextInstanceDataAutoConfiguration.class})
@Slf4j
public class AwsConfig {

    @Value("${aws.access.key}")
    private String accessKey;

    @Value("${aws.secret.key}")
    private String secretKey;

    @Bean
    public BasicAWSCredentials AwsCredentials() {
        return new BasicAWSCredentials(accessKey, secretKey);
    }

    /**
     * @see org.springframework.cloud.aws
     *
     * >  해당 패키지가, 의문의 credential chain 을 생성해서 `AmazonS3` 객체를 주입해버림
     *  따라서, DI 의 우선순위를 먼저 두어 커스텀 인증 자격 체인 객체를 갖도록 조치
     */
    @Bean
    @Primary
    public AmazonS3 AwsS3Client() {
        return AmazonS3ClientBuilder.standard()
                .withRegion(Regions.AP_NORTHEAST_2)
                .withCredentials(new AWSStaticCredentialsProvider(this.AwsCredentials()))
                .build();
    }
}
