import type { FC } from 'react';
import { View, Text, StyleSheet } from 'react-native';

export const FEATURE_NAMEScreen: FC = () => {
  return (
    <View style={styles.container}>
      <Text>FEATURE_NAME Screen</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
}); 