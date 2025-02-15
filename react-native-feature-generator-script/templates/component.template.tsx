import type { FC } from 'react';
import { View, Text, StyleSheet } from 'react-native';

interface FEATURE_NAMEComponentProps {
  title?: string;
}

export const FEATURE_NAMEComponent: FC<FEATURE_NAMEComponentProps> = ({ title }) => {
  return (
    <View style={styles.container}>
      <Text>{title}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 16,
  },
}); 