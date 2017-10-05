import tensorflow as tf
import numpy as np
import os,glob,cv2
import sys,argparse


class Model:
    graph = None
    sess = None

    def init(self, sess):
        self.sess = sess
        saver = tf.train.import_meta_graph('cow-notcow-model.meta')
        # Step-2: Now let's load the weights saved using the restore method.
        saver.restore(sess, tf.train.latest_checkpoint('./'))

        # Accessing the default graph which we have restored
        self.graph = tf.get_default_graph()


    def predict(self, image):

        image_size=128
        num_channels=3
        images = []

        # Resizing the image to our desired size and preprocessing will be done exactly as done during training
        image = cv2.resize(image, (image_size, image_size), cv2.INTER_LINEAR)
        images.append(image)
        images = np.array(images, dtype=np.uint8)
        images = images.astype('float32')
        images = np.multiply(images, 1.0/255.0)
        #The input to the network is of shape [None image_size image_size num_channels]. Hence we reshape.
        x_batch = images.reshape(1, image_size,image_size,num_channels)

        # Now, let's get hold of the op that we can be processed to get the output.
        # In the original network y_pred is the tensor that is the prediction of the network
        y_pred = self.graph.get_tensor_by_name("y_pred:0")

        ## Let's feed the images to the input placeholders
        x= self.graph.get_tensor_by_name("x:0")
        y_true = self.graph.get_tensor_by_name("y_true:0")
        y_test_images = np.zeros((1, 2))


        ### Creating the feed_dict that is required to be fed to calculate y_pred
        feed_dict_testing = {x: x_batch, y_true: y_test_images}
        result=self.sess.run(y_pred, feed_dict=feed_dict_testing)
        # result is of this format [probabiliy_of_rose probability_of_sunflower]
        return result
