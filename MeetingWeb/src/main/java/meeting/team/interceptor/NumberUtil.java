package meeting.team.interceptor;

import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class NumberUtil {

	/**
	 * Ư������ ���տ��� ���� ���ڸ� ���ϴ� ��� ���ۼ��ڿ� ������� ���̿��� ���� ���� ���ڸ� ��ȯ�Ѵ�
	 *
	 * @param startNum
	 *            - ���ۼ���
	 * @param endNum
	 *            - �������
	 * @return ��������
	 * @exception MyException
	 * @see
	 */
	public static int getRandomNum(int startNum, int endNum) {
		int randomNum = 0;

		try {
			// ���� ��ü ����
			SecureRandom rnd = new SecureRandom();

			do {
				// ������ڳ����� ���� ���ڸ� �߻���Ų��.
				randomNum = rnd.nextInt(endNum + 1);
			} while (randomNum < startNum); // ���� ���ڰ� ���ۼ��ں��� ������� �ٽ� �������ڸ�
											// �߻���Ų��.
		} catch (Exception e) {
			// e.printStackTrace();
			throw new RuntimeException(e); // 2011.10.10 �������� �ļ���ġ
		}

		return randomNum;
	}

	/**
	 * Ư�� ���� ���տ��� Ư�� ���ڰ� �ִ��� üũ�ϴ� ��� 12345678���� 7�� �ִ��� ������ üũ�ϴ� ����� ������
	 *
	 * @param sourceInt
	 *            - Ư����������
	 * @param searchInt
	 *            - �˻�����
	 * @return ���翩��
	 * @exception MyException
	 * @see
	 */
	public static Boolean getNumSearchCheck(int sourceInt, int searchInt) {
		String sourceStr = String.valueOf(sourceInt);
		String searchStr = String.valueOf(searchInt);

		// Ư�����ڰ� �����ϴ��� �Ͽ� ��ġ���� �����Ѵ�. ���� �� -1
		if (sourceStr.indexOf(searchStr) == -1) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * ����Ÿ���� ���ڿ��� ��ȯ�ϴ� ��� ���� 20081212�� ���ڿ� '20081212'�� ��ȯ�ϴ� ���
	 *
	 * @param srcNumber
	 *            - ����
	 * @return ���ڿ�
	 * @exception MyException
	 * @see
	 */
	public static String getNumToStrCnvr(int srcNumber) {
		String rtnStr = null;

		try {
			rtnStr = String.valueOf(srcNumber);
		} catch (Exception e) {
			// e.printStackTrace();
			throw new RuntimeException(e);
		}

		return rtnStr;
	}

	/**
	 * ����Ÿ���� ����Ʈ Ÿ������ ��ȯ�ϴ� ��� ���� 20081212�� ����ƮŸ�� '2008-12-12'�� ��ȯ�ϴ� ���
	 * 
	 * @param srcNumber
	 *            - ����
	 * @return String
	 * @exception MyException
	 * @see
	 */
	public static String getNumToDateCnvr(int srcNumber) {

		String pattern = null;
		String cnvrStr = null;

		String srcStr = String.valueOf(srcNumber);

		// Date ������ 8�ڸ� �� 14�ڸ��� ����ó��
		if (srcStr.length() != 8 && srcStr.length() != 14) {
			throw new IllegalArgumentException("Invalid Number: " + srcStr + " Length=" + srcStr.trim().length());
		}

		if (srcStr.length() == 8) {
			pattern = "yyyyMMdd";
		} else if (srcStr.length() == 14) {
			pattern = "yyyyMMddhhmmss";
		}

		SimpleDateFormat dateFormatter = new SimpleDateFormat(pattern, Locale.KOREA);

		Date cnvrDate = null;

		try {
			cnvrDate = dateFormatter.parse(srcStr);
		} catch (ParseException e) {
			// e.printStackTrace();
			throw new RuntimeException(e);
		}

		cnvrStr = String.format("%1$tY-%1$tm-%1$td", cnvrDate);

		return cnvrStr;

	}

	/**
	 * üũ�� ���� �߿��� �������� �ƴ��� üũ�ϴ� ��� �����̸� True, �ƴϸ� False�� ��ȯ�Ѵ�
	 * 
	 * @param checkStr
	 *            - üũ���ڿ�
	 * @return ���ڿ���
	 * @exception MyException
	 * @see
	 */
	public static Boolean getNumberValidCheck(String checkStr) {

		int i;
		// String sourceStr = String.valueOf(sourceInt);

		int checkStrLt = checkStr.length();

		try {
			for (i = 0; i < checkStrLt; i++) {

				// �ƽ�Ű�ڵ尪( '0'-> 48, '9' -> 57)
				if (checkStr.charAt(i) > 47 && checkStr.charAt(i) < 58) {
					continue;
				} else {
					return false;
				}
			}
		} catch (Exception e) {
			// e.printStackTrace();
			throw new RuntimeException(e);
		}

		return true;
	}

	/**
	 * Ư�����ڸ� �ٸ� ���ڷ� ġȯ�ϴ� ��� ���� 12345678���� 123�� 999�� ��ȯ�ϴ� ����� ����(99945678)
	 *
	 * @param srcNumber
	 *            - ��������
	 * @param cnvrSrcNumber
	 *            - ��������
	 * @param cnvrTrgtNumber
	 *            - ġȯ����
	 * @return ġȯ����
	 * @exception MyException
	 * @see
	 */

	public static int getNumberCnvr(int srcNumber, int cnvrSrcNumber, int cnvrTrgtNumber) {

		// �Է¹��� ���ڸ� ���ڿ��� ��ȯ
		String source = String.valueOf(srcNumber);
		String subject = String.valueOf(cnvrSrcNumber);
		String object = String.valueOf(cnvrTrgtNumber);

		StringBuffer rtnStr = new StringBuffer();
		String preStr = "";
		String nextStr = source;

		try {

			// �������ڿ��� ��ȯ�������� ��ġ�� ã�´�.
			while (source.indexOf(subject) >= 0) {
				preStr = source.substring(0, source.indexOf(subject)); // ��ȯ������
																		// ��ġ����
																		// ���ڸ�
																		// �߶󳽴�
				nextStr = source.substring(source.indexOf(subject) + subject.length(), source.length());
				source = nextStr;
				rtnStr.append(preStr).append(object); // ��ȯ�����ġ ���ڿ� ��ȯ�� ���ڸ�
														// �ٿ��ش�.
			}
			rtnStr.append(nextStr); // ��ȯ��� ���� ���� ���ڸ� �ٿ��ش�.
		} catch (Exception e) {
			// e.printStackTrace();
			throw new RuntimeException(e);
		}

		return Integer.parseInt(rtnStr.toString());
	}

	/**
	 * Ư�����ڰ� �Ǽ�����, ��������, �������� üũ�ϴ� ��� 123�� �Ǽ�����, ��������, �������� üũ�ϴ� ����� ������
	 *
	 * @param srcNumber
	 *            - ��������
	 * @return -1(����), 0(����), 1(�Ǽ�)
	 * @exception MyException
	 * @see
	 */
	public static int checkRlnoInteger(double srcNumber) {

		// byte 1����Ʈ ���Ҽ����� ���� ���ڷ�, ���� -2^7 ~ 2^7 -1
		// short 2����Ʈ ���Ҽ����� ���� ���ڷ�, ���� -2^15 ~ 2^15 -1
		// int 4����Ʈ ���Ҽ����� ���� ���ڷ�, ���� -2^31 ~ 2^31 - 1
		// long 8����Ʈ ���Ҽ����� ���� ���ڷ�, ���� -2^63 ~ 2^63-1

		// float 4����Ʈ ���Ҽ����� �ִ� ���ڷ�, ���� F �Ǵ� f �� �ٴ� ���� (��:3.14f)
		// double 8����Ʈ ���Ҽ����� �ִ� ���ڷ�, ���� �ƹ��͵� ���� �ʴ� ���� (��:3.14)
		// ���Ҽ����� �ִ� ���ڷ�, ���� D �Ǵ� d �� �ٴ� ����(��:3.14d)

		String cnvrString = null;

		if (srcNumber < 0) {
			return -1;
		} else {
			cnvrString = String.valueOf(srcNumber);

			if (cnvrString.indexOf(".") == -1) {
				return 0;
			} else {
				return 1;
			}
		}
	}

}
